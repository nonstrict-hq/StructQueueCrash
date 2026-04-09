import Foundation

public final class LeakyRebuildingBufferBox: @unchecked Sendable {
    public var buffer = LeakyRebuildingBuffer()
    public init() {}
}

public struct LeakyRebuildingBuffer: Sendable {
    private let queue = DispatchQueue(label: "LeakyRebuildingBuffer")
    private var _array: [Int] = []

    public init() {}

    public mutating func append(_ element: Int) {
        self = self._append(element)
    }

    public func _append(_ element: Int) -> LeakyRebuildingBuffer {
        var copy = self
        copy.queue.sync {
            copy._array.append(element)
        }
        return copy
    }
}
