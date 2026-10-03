import SwiftUI

struct MenuItemRow: View {
    let drink: Drink

    var body: some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: Tokens.Radius.tile)
                .fill(drink.tile)
                .frame(width: 56, height: 56)
                .overlay(Circle().fill(Tokens.glow).frame(width: 24, height: 24))
            VStack(alignment: .leading, spacing: 2) {
                Text(drink.name).font(.system(size: 16, weight: .semibold)).foregroundStyle(Tokens.ink)
                Text(drink.blurb).font(.system(size: 13)).foregroundStyle(Tokens.muted).lineLimit(1).minimumScaleFactor(0.85)
            }
            Spacer(minLength: 0)
            Text(Money.format(drink.priceCents))
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(Tokens.caramel)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .frame(height: 88)
        .background(Tokens.surface)
        .clipShape(RoundedRectangle(cornerRadius: Tokens.Radius.card))
        .overlay(RoundedRectangle(cornerRadius: Tokens.Radius.card).strokeBorder(Tokens.line, lineWidth: 1))
    }
}
