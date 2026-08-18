import Foundation
import SwiftTreeSitter
import TreeSitter

import TreeSitterAstro
import TreeSitterAstroQueries
import TreeSitterBash
import TreeSitterBashQueries
import TreeSitterC
import TreeSitterCQueries
import TreeSitterCPP
import TreeSitterCPPQueries
import TreeSitterCSharp
import TreeSitterCSharpQueries
import TreeSitterCSS
import TreeSitterCSSQueries
import TreeSitterComment
import TreeSitterCommentQueries
import TreeSitterElixir
import TreeSitterElixirQueries
import TreeSitterElm
import TreeSitterElmQueries
import TreeSitterGo
import TreeSitterGoQueries
import TreeSitterHTML
import TreeSitterHTMLQueries
import TreeSitterHaskell
import TreeSitterHaskellQueries
import TreeSitterJSDoc
import TreeSitterJSDocQueries
import TreeSitterJSON
import TreeSitterJSONQueries
import TreeSitterJSON5
import TreeSitterJSON5Queries
import TreeSitterJava
import TreeSitterJavaQueries
import TreeSitterJavaScript
import TreeSitterJavaScriptQueries
import TreeSitterJulia
import TreeSitterJuliaQueries
import TreeSitterLaTeX
import TreeSitterLaTeXQueries
import TreeSitterLua
import TreeSitterLuaQueries
import TreeSitterMarkdown
import TreeSitterMarkdownQueries
import TreeSitterMarkdownInline
import TreeSitterMarkdownInlineQueries
import TreeSitterOCaml
import TreeSitterOCamlQueries
import TreeSitterPHP
import TreeSitterPHPQueries
import TreeSitterPerl
import TreeSitterPerlQueries
import TreeSitterPython
import TreeSitterPythonQueries
import TreeSitterR
import TreeSitterRQueries
import TreeSitterRegex
import TreeSitterRegexQueries
import TreeSitterRuby
import TreeSitterRubyQueries
import TreeSitterRust
import TreeSitterRustQueries
import TreeSitterSCSS
import TreeSitterSCSSQueries
import TreeSitterSQL
import TreeSitterSQLQueries
import TreeSitterSvelte
import TreeSitterSvelteQueries
import TreeSitterSwift
import TreeSitterSwiftQueries
import TreeSitterTOML
import TreeSitterTOMLQueries
import TreeSitterTSX
import TreeSitterTSXQueries
import TreeSitterTypeScript
import TreeSitterTypeScriptQueries
import TreeSitterYAML
import TreeSitterYAMLQueries

public enum TreeSitterLanguage: CaseIterable, Hashable, Sendable {
    case astro
    case bash
    case c
    case comment
    case cpp
    case csharp
    case css
    case elixir
    case elm
    case go
    case haskell
    case html
    case java
    case javascript
    case jsdoc
    case json
    case json5
    case julia
    case latex
    case lua
    case markdown
    case markdownInline
    case ocaml
    case perl
    case php
    case python
    case r
    case regex
    case ruby
    case rust
    case scss
    case sql
    case svelte
    case swift
    case toml
    case tsx
    case typescript
    case yaml

    public var parser: OpaquePointer {
        switch self {
        case .astro: tree_sitter_astro()
        case .bash: tree_sitter_bash()
        case .c: tree_sitter_c()
        case .comment: tree_sitter_comment()
        case .cpp: tree_sitter_cpp()
        case .csharp: tree_sitter_c_sharp()
        case .css: tree_sitter_css()
        case .elixir: tree_sitter_elixir()
        case .elm: tree_sitter_elm()
        case .go: tree_sitter_go()
        case .haskell: tree_sitter_haskell()
        case .html: tree_sitter_html()
        case .java: tree_sitter_java()
        case .javascript: tree_sitter_javascript()
        case .jsdoc: tree_sitter_jsdoc()
        case .json: tree_sitter_json()
        case .json5: tree_sitter_json5()
        case .julia: tree_sitter_julia()
        case .latex: tree_sitter_latex()
        case .lua: tree_sitter_lua()
        case .markdown: tree_sitter_markdown()
        case .markdownInline: tree_sitter_markdown_inline()
        case .ocaml: tree_sitter_ocaml()
        case .perl: tree_sitter_perl()
        case .php: tree_sitter_php()
        case .python: tree_sitter_python()
        case .r: tree_sitter_r()
        case .regex: tree_sitter_regex()
        case .ruby: tree_sitter_ruby()
        case .rust: tree_sitter_rust()
        case .scss: tree_sitter_scss()
        case .sql: tree_sitter_sql()
        case .svelte: tree_sitter_svelte()
        case .swift: tree_sitter_swift()
        case .toml: tree_sitter_toml()
        case .tsx: tree_sitter_tsx()
        case .typescript: tree_sitter_typescript()
        case .yaml: tree_sitter_yaml()
        }
    }

    public var name: String {
        switch self {
        case .astro: "astro"
        case .bash: "bash"
        case .c: "c"
        case .comment: "comment"
        case .cpp: "cpp"
        case .csharp: "c_sharp"
        case .css: "css"
        case .elixir: "elixir"
        case .elm: "elm"
        case .go: "go"
        case .haskell: "haskell"
        case .html: "html"
        case .java: "java"
        case .javascript: "javascript"
        case .jsdoc: "jsdoc"
        case .json: "json"
        case .json5: "json5"
        case .julia: "julia"
        case .latex: "latex"
        case .lua: "lua"
        case .markdown: "markdown"
        case .markdownInline: "markdown_inline"
        case .ocaml: "ocaml"
        case .perl: "perl"
        case .php: "php"
        case .python: "python"
        case .r: "r"
        case .regex: "regex"
        case .ruby: "ruby"
        case .rust: "rust"
        case .scss: "scss"
        case .sql: "sql"
        case .svelte: "svelte"
        case .swift: "swift"
        case .toml: "toml"
        case .tsx: "tsx"
        case .typescript: "typescript"
        case .yaml: "yaml"
        }
    }

    public var highlightQueryURL: URL? {
        switch self {
        case .astro: TreeSitterAstroQueries.Query.highlightsFileURL
        case .bash: TreeSitterBashQueries.Query.highlightsFileURL
        case .c: TreeSitterCQueries.Query.highlightsFileURL
        case .comment: TreeSitterCommentQueries.Query.highlightsFileURL
        case .cpp: TreeSitterCPPQueries.Query.highlightsFileURL
        case .csharp: TreeSitterCSharpQueries.Query.highlightsFileURL
        case .css: TreeSitterCSSQueries.Query.highlightsFileURL
        case .elixir: TreeSitterElixirQueries.Query.highlightsFileURL
        case .elm: TreeSitterElmQueries.Query.highlightsFileURL
        case .go: TreeSitterGoQueries.Query.highlightsFileURL
        case .haskell: TreeSitterHaskellQueries.Query.highlightsFileURL
        case .html: TreeSitterHTMLQueries.Query.highlightsFileURL
        case .java: TreeSitterJavaQueries.Query.highlightsFileURL
        case .javascript: TreeSitterJavaScriptQueries.Query.highlightsFileURL
        case .jsdoc: TreeSitterJSDocQueries.Query.highlightsFileURL
        case .json: TreeSitterJSONQueries.Query.highlightsFileURL
        case .json5: TreeSitterJSON5Queries.Query.highlightsFileURL
        case .julia: TreeSitterJuliaQueries.Query.highlightsFileURL
        case .latex: TreeSitterLaTeXQueries.Query.highlightsFileURL
        case .lua: TreeSitterLuaQueries.Query.highlightsFileURL
        case .markdown: TreeSitterMarkdownQueries.Query.highlightsFileURL
        case .markdownInline: TreeSitterMarkdownInlineQueries.Query.highlightsFileURL
        case .ocaml: TreeSitterOCamlQueries.Query.highlightsFileURL
        case .perl: TreeSitterPerlQueries.Query.highlightsFileURL
        case .php: TreeSitterPHPQueries.Query.highlightsFileURL
        case .python: TreeSitterPythonQueries.Query.highlightsFileURL
        case .r: TreeSitterRQueries.Query.highlightsFileURL
        case .regex: TreeSitterRegexQueries.Query.highlightsFileURL
        case .ruby: TreeSitterRubyQueries.Query.highlightsFileURL
        case .rust: TreeSitterRustQueries.Query.highlightsFileURL
        case .scss: TreeSitterSCSSQueries.Query.highlightsFileURL
        case .sql: TreeSitterSQLQueries.Query.highlightsFileURL
        case .svelte: TreeSitterSvelteQueries.Query.highlightsFileURL
        case .swift: TreeSitterSwiftQueries.Query.highlightsFileURL
        case .toml: TreeSitterTOMLQueries.Query.highlightsFileURL
        case .tsx: TreeSitterTSXQueries.Query.highlightsFileURL
        case .typescript: TreeSitterTypeScriptQueries.Query.highlightsFileURL
        case .yaml: TreeSitterYAMLQueries.Query.highlightsFileURL
        }
    }

    public var localsQueryURL: URL? {
        switch self {
        case .javascript: TreeSitterJavaScriptQueries.Query.localsFileURL
        case .ocaml: TreeSitterOCamlQueries.Query.localsFileURL
        case .ruby: TreeSitterRubyQueries.Query.localsFileURL
        case .swift: TreeSitterSwiftQueries.Query.localsFileURL
        case .tsx: TreeSitterTSXQueries.Query.localsFileURL
        case .typescript: TreeSitterTypeScriptQueries.Query.localsFileURL
        default: nil
        }
    }

    public var queryDirectoryURL: URL? {
        highlightQueryURL?.deletingLastPathComponent()
    }

    public var configuration: LanguageConfiguration? {
        guard let queryDirectoryURL else { return nil }

        return try? LanguageConfiguration(
            SwiftTreeSitter.Language(parser),
            name: name,
            queriesURL: queryDirectoryURL
        )
    }

    public static func injectedLanguage(named name: String) -> TreeSitterLanguage? {
        switch name {
        case "astro": .astro
        case "bash", "sh", "shell": .bash
        case "c": .c
        case "comment": .comment
        case "cpp", "c++": .cpp
        case "c_sharp", "csharp": .csharp
        case "css": .css
        case "elixir": .elixir
        case "elm": .elm
        case "go": .go
        case "haskell": .haskell
        case "html": .html
        case "java": .java
        case "javascript", "js": .javascript
        case "jsdoc": .jsdoc
        case "json": .json
        case "json5": .json5
        case "julia": .julia
        case "latex": .latex
        case "lua": .lua
        case "markdown": .markdown
        case "markdown_inline", "markdown-inline": .markdownInline
        case "ocaml": .ocaml
        case "perl": .perl
        case "php": .php
        case "python", "py": .python
        case "r": .r
        case "regex": .regex
        case "ruby", "rb": .ruby
        case "rust", "rs": .rust
        case "scss": .scss
        case "sql": .sql
        case "svelte": .svelte
        case "swift": .swift
        case "toml": .toml
        case "tsx": .tsx
        case "typescript", "ts": .typescript
        case "yaml", "yml": .yaml
        default: nil
        }
    }

    public static func languageProvider(named name: String) -> LanguageConfiguration? {
        injectedLanguage(named: name)?.configuration
    }
}
