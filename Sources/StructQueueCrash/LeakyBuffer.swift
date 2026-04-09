import Foundation

public final class Item: Sendable {
    public init() {}
}

public final class LeakyBufferBox: @unchecked Sendable {
    public var buffer = LeakyBuffer()
    public init() {}
}

public struct LeakyBuffer: Sendable {
    private let queue = DispatchQueue(label: "LeakyBuffer")
    private var _items: [Item] = []

    public init() {}

    public mutating func append(_ item: Item) {
        queue.sync { _items.append(item) }
    }
}
