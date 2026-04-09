import Foundation
import XCTest
@testable import StructQueueCrash

final class LeakyRebuildingBufferTests: XCTestCase {

    func testLeakyRebuildingBufferCrashes() {
        let box = LeakyRebuildingBufferBox()

        let iterations = 200_000
        let group = DispatchGroup()

        DispatchQueue.global().async(group: group) {
            for i in 0..<iterations {
                box.buffer.append(i)
            }
        }
        for _ in 0..<4 {
            DispatchQueue.global().async(group: group) {
                for _ in 0..<iterations {
                    let copy = box.buffer
                    _ = copy
                }
            }
        }
        group.wait()
    }
}
