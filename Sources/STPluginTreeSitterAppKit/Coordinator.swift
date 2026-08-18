import AppKit
import STPluginTreeSitterCore
import STTextView
import TreeSitterResource

@MainActor
public final class Coordinator {
    private let language: TreeSitterLanguage
    private let service: SyntaxHighlightService?
    private let attributeApplier: SyntaxAttributeApplier
    private weak var textView: STTextView?
    private var pendingEdit: PendingTextEdit?
    private var previousViewportRange: NSTextRange?

    init(textView: STTextView, theme: Theme, language: TreeSitterLanguage) {
        self.textView = textView
        self.language = language
        self.attributeApplier = SyntaxAttributeApplier(textView: textView, theme: theme)
        textView.font = theme.font(forToken: "plain") ?? textView.font

        if let configuration = language.configuration,
           let client = try? TreeSitterClient(
               languageConfiguration: configuration,
               languageProvider: TreeSitterLanguage.languageProvider(named:)
           ) {
            let attributeApplier = self.attributeApplier
            self.service = SyntaxHighlightService(treeSitterClient: client) { update in
                await MainActor.run { attributeApplier.apply(update) }
            }
        } else {
            self.service = nil
        }

        requestInitialHighlighting()
    }

    func updateViewportRange(_ range: NSTextRange?) {
        if range != previousViewportRange {
            requestInitialHighlighting()
        }
        previousViewportRange = range
    }

    func willChangeContent(in affectedRange: NSTextRange, replacementString: String?) {
        guard let textView,
              let replacementString,
              let oldText = textView.textContentManager.attributedString(in: nil)?.string else {
            pendingEdit = nil
            return
        }

        let range = NSRange(affectedRange, in: textView.textContentManager)
        guard range.location >= 0, NSMaxRange(range) <= oldText.utf16.count else {
            pendingEdit = nil
            return
        }

        pendingEdit = PendingTextEdit(oldText: oldText, oldRange: range, replacementText: replacementString)
    }

    func didChangeContent(_ textContentManager: NSTextContentManager, in affectedRange: NSTextRange, replacementString: String?) {
        guard let content = textContentManager.attributedString(in: nil)?.string else { return }
        let edit = pendingEdit
        pendingEdit = nil

        Task {
            if let edit, edit.newLength == content.utf16.count {
                await service?.requestHighlighting(content: content, edit: edit)
            } else {
                await service?.requestInitialHighlighting(content)
            }
        }
    }

    private func requestInitialHighlighting() {
        guard let textView,
              let content = textView.textContentManager.attributedString(in: nil)?.string else { return }
        Task { await service?.requestInitialHighlighting(content) }
    }
}
