import Foundation
import XCTest
@testable import StructQueueCrash

final class LeakyBufferTests: XCTestCase {

    func testLeakyBufferCrashes() {
        let box = LeakyBufferBox()

        let group = DispatchGroup()
        DispatchQueue.global().async(group: group) {
            for _ in 0..<200_000 {
                box.buffer.append(Item())
            }
        }
        DispatchQueue.global().async(group: group) {
            for _ in 0..<200_000 {
                let copy = box.buffer
                _ = copy
            }
        }
        group.wait()
    }
}
