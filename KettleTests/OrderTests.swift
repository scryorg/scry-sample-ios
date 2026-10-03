import XCTest
@testable import Kettle

final class OrderTests: XCTestCase {
    func testDefaultOrderTotalsMatchTheSpec() {
        let order = Fixtures.order
        XCTAssertEqual(order.itemCount, 2)
        XCTAssertEqual(Money.format(order.subtotalCents), "$9.25")
        XCTAssertEqual(Money.format(order.taxCents), "$0.76")
        XCTAssertEqual(Money.format(order.totalCents), "$10.01")
    }

    func testAddingTheSameDrinkIncreasesItsQuantity() {
        var order = Fixtures.order
        order.add(Fixtures.drinks[0], quantity: 2)
        XCTAssertEqual(order.lines.count, 2)
        XCTAssertEqual(order.lines[0].quantity, 3)
        order.add(Fixtures.drinks[3], quantity: 1)
        XCTAssertEqual(order.lines.count, 3)
    }
}
