// Design tokens: the same numbers as the Kettle React Native sample (src/tokens.ts) and the Kettle Figma file.
import SwiftUI

extension Color {
    init(hex: UInt32, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: opacity
        )
    }
}

enum Tokens {
    static let bg = Color(hex: 0xFBF7F2)
    static let surface = Color(hex: 0xFFFFFF)
    static let ink = Color(hex: 0x2B1D14)
    static let muted = Color(hex: 0x7A6A5E)
    static let line = Color(hex: 0xEADFD3)
    static let espresso = Color(hex: 0x3B2A20)
    static let caramel = Color(hex: 0xB8621B)
    /// White at 35% opacity: the circle drawn on tiles and on the hero.
    static let glow = Color(hex: 0xFFFFFF, opacity: 0.35)

    enum Radius {
        static let card: CGFloat = 16
        static let tile: CGFloat = 12
        static let hero: CGFloat = 20
        static let button: CGFloat = 14
        static let stepper: CGFloat = 22
    }
}
