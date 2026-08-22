import AppKit
import STPluginTreeSitterCore
import STTextView

@MainActor
final class SyntaxAttributeApplier {
    private let textView: STTextView
    private let theme: Theme
    private var generation = 0

    init(textView: STTextView, theme: Theme) {
        self.textView = textView
        self.theme = theme
    }

    func apply(_ update: HighlightUpdate) {
        guard update.generation >= generation else { return }
        generation = update.generation

        let length = textView.textContentManager.length
        let invalidatedRanges = normalizedRanges(update.invalidatedRanges, maxLength: length)
        guard invalidatedRanges.isEmpty == false else { return }

        let tokensToApply = update.tokens.filter { token in
            invalidatedRanges.contains { rangesOverlap($0, token.range) }
        }

        let baseStyle = style(forToken: "plain")
        textView.textContentManager.performEditingTransaction {
            for range in invalidatedRanges {
                self.clearRenderingAttributes(in: range)
                self.apply(baseStyle, range: range)
            }

            for run in self.coalescedTokenRuns(tokensToApply) {
                self.apply(run.style, range: run.range)
            }
        }
        textView.needsLayout = true
    }

    private func clearRenderingAttributes(in range: NSRange) {
        guard let textRange = NSTextRange(range, in: textView.textContentManager) else { return }
        textView.textLayoutManager.removeRenderingAttribute(.foregroundColor, for: textRange)
    }

    private func apply(_ style: TokenStyle, range: NSRange) {
        guard range.location >= 0, NSMaxRange(range) <= textView.textContentManager.length else { return }

        if let color = style.color,
           let textRange = NSTextRange(range, in: textView.textContentManager) {
            textView.textLayoutManager.addRenderingAttribute(.foregroundColor, value: color, for: textRange)
        }
        textView.addAttributes([.font: style.font], range: range)
    }

    private struct TokenStyle {
        let color: NSColor?
        let font: NSFont
    }

    private struct TokenRun {
        let range: NSRange
        let style: TokenStyle
    }

    private func coalescedTokenRuns(_ tokens: [SyntaxToken]) -> [TokenRun] {
        let sorted = tokens.sorted {
            if $0.range.location != $1.range.location { return $0.range.location < $1.range.location }
            // Longest first at a shared start location. Runs are painted in
            // order and later writes win, so an enclosing capture has to land
            // before the narrower captures nested inside it. Ascending length
            // inverted that: `@none` over a fenced block repainted the block's
            // first token, and `@text.title` repainted emphasis that began at
            // the heading's first inline character.
            if $0.range.length != $1.range.length { return $0.range.length > $1.range.length }
            return $0.nameComponents.count < $1.nameComponents.count
        }

        var runs: [TokenRun] = []
        for token in sorted {
            let style = style(forToken: TokenName(token.name))
            if let last = runs.last,
               NSMaxRange(last.range) == token.range.location,
               sameStyle(last.style, style) {
                runs[runs.count - 1] = TokenRun(
                    range: NSRange(location: last.range.location, length: last.range.length + token.range.length),
                    style: style
                )
            } else {
                runs.append(TokenRun(range: token.range, style: style))
            }
        }
        return runs
    }

    private func style(forToken tokenName: TokenName) -> TokenStyle {
        TokenStyle(
            color: theme.color(forToken: tokenName) ?? theme.color(forToken: "plain"),
            font: theme.font(forToken: tokenName) ?? theme.font(forToken: "plain") ?? textView.font
        )
    }

    private func sameStyle(_ lhs: TokenStyle, _ rhs: TokenStyle) -> Bool {
        let sameColor = switch (lhs.color, rhs.color) {
        case (nil, nil): true
        case let (left?, right?): left.isEqual(right)
        default: false
        }
        return sameColor && lhs.font.isEqual(rhs.font)
    }
}
