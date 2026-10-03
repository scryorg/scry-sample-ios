// Checks the capture registry (Debug builds only: ScryScreens does not exist in Release).
#if DEBUG
import XCTest
@testable import Kettle

final class ScryRegistryTests: XCTestCase {
    /// KettleTests/ScryRegistryTests.swift -> the repo root.
    private var repoRoot: URL {
        URL(fileURLWithPath: #filePath).deletingLastPathComponent().deletingLastPathComponent()
    }

    func testIdsAreUniqueAndStable() {
        let ids = ScryScreens.all.map(\.id)
        XCTAssertEqual(ids, ["menu", "item-detail", "order", "button", "quantity-stepper"])
        XCTAssertEqual(Set(ids).count, ids.count)
    }

    func testEveryEntryPointsAtARealDeclaration() throws {
        for screen in ScryScreens.all {
            let url = repoRoot.appendingPathComponent(screen.file)
            let lines = try String(contentsOf: url, encoding: .utf8).components(separatedBy: "\n")
            XCTAssertTrue(lines.indices.contains(screen.line - 1), "\(screen.id): line \(screen.line) is past the end of \(screen.file)")
            XCTAssertTrue(lines[screen.line - 1].contains("struct "), "\(screen.id): \(screen.file):\(screen.line) is not a declaration")
        }
    }
}
#endif
