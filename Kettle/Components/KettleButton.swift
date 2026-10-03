import SwiftUI

struct KettleButton: View {
    enum Style { case primary, secondary }

    let title: String
    var style: Style = .primary
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(style == .primary ? Color.white : Tokens.ink)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(style == .primary ? Tokens.espresso : Tokens.surface)
                .clipShape(RoundedRectangle(cornerRadius: Tokens.Radius.button))
                .overlay(
                    RoundedRectangle(cornerRadius: Tokens.Radius.button)
                        .strokeBorder(style == .secondary ? Tokens.line : Color.clear, lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }
}
