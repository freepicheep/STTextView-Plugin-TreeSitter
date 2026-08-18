import XCTest
@testable import STPluginTreeSitterCore
import TreeSitterResource

final class TreeSitterClientTests: XCTestCase {
    func testSwiftResetProducesHighlightTokens() throws {
        let configuration = try XCTUnwrap(TreeSitterLanguage.swift.configuration)
        let client = try TreeSitterClient(
            languageConfiguration: configuration,
            languageProvider: TreeSitterLanguage.languageProvider(named:)
        )

        let tokens = try client.resetDocument(content: "let message = \"Hello\"\n")

        XCTAssertFalse(tokens.isEmpty)
        XCTAssertTrue(tokens.contains { $0.name == "keyword" })
        XCTAssertTrue(tokens.contains { $0.name == "string" })
    }

    func testIncrementalEditProducesChangedRanges() throws {
        let configuration = try XCTUnwrap(TreeSitterLanguage.swift.configuration)
        let client = try TreeSitterClient(
            languageConfiguration: configuration,
            languageProvider: TreeSitterLanguage.languageProvider(named:)
        )
        let oldText = "let message = \"Hello\"\n"
        _ = try client.resetDocument(content: oldText)

        let insertionRange = NSRange(location: 0, length: 0)
        let edit = PendingTextEdit(oldText: oldText, oldRange: insertionRange, replacementText: "// comment\n")
        let newText = "// comment\n" + oldText
        let result = try client.didChangeDocument(content: newText, edit: edit)

        XCTAssertFalse(result.changedRanges.isEmpty)
        XCTAssertFalse(result.tokens.isEmpty)
        XCTAssertTrue(result.changedRanges.contains { $0.location == 0 })
    }
}
