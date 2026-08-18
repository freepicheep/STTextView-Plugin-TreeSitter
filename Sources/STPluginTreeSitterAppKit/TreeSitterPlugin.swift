import AppKit
import STTextView
import TreeSitterResource

public struct TreeSitterPlugin: STPlugin {
    private let theme: Theme
    private let language: TreeSitterLanguage

    public init(theme: Theme = .default, language: TreeSitterLanguage) {
        self.theme = theme
        self.language = language
    }

    public func setUp(context: any Context) {
        context.events.onWillChangeText { affectedRange, replacementString in
            context.coordinator.willChangeContent(in: affectedRange, replacementString: replacementString)
        }

        context.events.onDidChangeText { affectedRange, replacementString in
            context.coordinator.didChangeContent(
                context.textView.textContentManager,
                in: affectedRange,
                replacementString: replacementString
            )
        }

        context.events.onDidLayoutViewport { viewportRange in
            context.coordinator.updateViewportRange(viewportRange)
        }
    }

    public func makeCoordinator(context: CoordinatorContext) -> Coordinator {
        Coordinator(textView: context.textView, theme: theme, language: language)
    }
}
