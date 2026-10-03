// Fixed data for the whole app: no network, no sign-in, no clock. The same copy as the Kettle React Native sample.
// A screen that renders from fixed data captures the same way every time.
import SwiftUI

struct Drink: Identifiable, Equatable {
    let id: String
    let name: String
    let blurb: String
    let priceCents: Int
    let tile: Color
    /// The two lines shown on the Item Detail screen.
    let detail: [String]

    static func == (a: Drink, b: Drink) -> Bool { a.id == b.id }
}

struct OrderLine: Equatable {
    let drink: Drink
    var quantity: Int
}

struct Order: Equatable {
    var lines: [OrderLine]

    var itemCount: Int { lines.reduce(0) { $0 + $1.quantity } }
    var subtotalCents: Int { lines.reduce(0) { $0 + $1.drink.priceCents * $1.quantity } }
    /// 8.25% sales tax, rounded to the nearest cent.
    var taxCents: Int { (subtotalCents * 825 + 5_000) / 10_000 }
    var totalCents: Int { subtotalCents + taxCents }

    mutating func add(_ drink: Drink, quantity: Int) {
        if let i = lines.firstIndex(where: { $0.drink == drink }) {
            lines[i].quantity += quantity
        } else {
            lines.append(OrderLine(drink: drink, quantity: quantity))
        }
    }
}

enum Money {
    static func format(_ cents: Int) -> String {
        String(format: "$%d.%02d", cents / 100, cents % 100)
    }
}

enum Fixtures {
    static let drinks: [Drink] = [
        Drink(id: "flat-white", name: "Flat White", blurb: "Double ristretto, silky milk", priceCents: 450,
              tile: Color(hex: 0xC89F7A),
              detail: ["A double ristretto with steamed whole milk,", "poured thin so the coffee still leads."]),
        Drink(id: "cold-brew", name: "Cold Brew", blurb: "Steeped 18 hours, over ice", priceCents: 475,
              tile: Color(hex: 0x5A3B2A),
              detail: ["Coarse-ground and steeped in cold water", "for 18 hours, then served straight over ice."]),
        Drink(id: "matcha-latte", name: "Matcha Latte", blurb: "Ceremonial grade, oat milk", priceCents: 525,
              tile: Color(hex: 0x8FA876),
              detail: ["Ceremonial-grade matcha whisked smooth,", "poured over oat milk, lightly sweetened."]),
        Drink(id: "cortado", name: "Cortado", blurb: "Equal parts espresso and milk", priceCents: 400,
              tile: Color(hex: 0xA9744F),
              detail: ["Equal parts espresso and steamed milk,", "cut just enough to soften the shot."]),
    ]

    /// The order every capture shows: a Flat White and a Cold Brew.
    static let order = Order(lines: [
        OrderLine(drink: drinks[0], quantity: 1),
        OrderLine(drink: drinks[1], quantity: 1),
    ])
}
