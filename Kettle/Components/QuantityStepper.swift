import SwiftUI

struct QuantityStepper: View {
    @Binding var count: Int
    var range: ClosedRange<Int> = 1...9

    var body: some View {
        HStack(spacing: 0) {
            Button { if count > range.lowerBound { count -= 1 } } label: {
                Bar(width: 14, height: 2).frame(width: 44, height: 44)
            }
            .accessibilityLabel("Decrease quantity")
            Text("\(count)")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Tokens.ink)
                .frame(width: 40, height: 44)
            Button { if count < range.upperBound { count += 1 } } label: {
                ZStack {
                    Bar(width: 14, height: 2)
                    Bar(width: 2, height: 14)
                }
                .frame(width: 44, height: 44)
            }
            .accessibilityLabel("Increase quantity")
        }
        .buttonStyle(.plain)
        .frame(width: 128, height: 44)
        .background(Tokens.surface)
        .clipShape(Capsule())
        .overlay(Capsule().strokeBorder(Tokens.line, lineWidth: 1))
    }

    private struct Bar: View {
        let width: CGFloat
        let height: CGFloat
        var body: some View {
            RoundedRectangle(cornerRadius: 1).fill(Tokens.ink).frame(width: width, height: height)
        }
    }
}
