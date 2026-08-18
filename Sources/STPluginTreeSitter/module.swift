import Foundation

#if os(macOS)
@_exported import STPluginTreeSitterAppKit
#endif

#if os(iOS) || targetEnvironment(macCatalyst)
@_exported import STPluginTreeSitterUIKit
#endif
