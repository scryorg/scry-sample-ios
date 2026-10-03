import SwiftUI

struct ItemDetailView: View {
    let drink: Drink
    @Binding var quantity: Int
    var onBack: () -> Void = {}
    var onAdd: () -> Void = {}

    var body: some View {
        ScreenFrame {
            VStack(alignment: .leading, spacing: 0) {
                Button(action: onBack) {
                    Text("Back").font(.system(size: 15, weight: .medium)).foregroundStyle(Tokens.muted)
                }
                .buttonStyle(.plain)
                RoundedRectangle(cornerRadius: Tokens.Radius.hero)
                    .fill(drink.tile)
                    .frame(height: 220)
                    .overlay(Circle().fill(Tokens.glow).frame(width: 96, height: 96))
                    .padding(.top, 16)
                Text(drink.name).font(.system(size: 26, weight: .bold)).foregroundStyle(Tokens.ink)
                    .padding(.top, 20)
                Text(Money.format(drink.priceCents))
                    .font(.system(size: 18, weight: .semibold)).foregroundStyle(Tokens.caramel)
                    .padding(.top, 4)
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(drink.detail, id: \.self) { line in
                        Text(line).font(.system(size: 15)).foregroundStyle(Tokens.muted).lineLimit(1)
                    }
                }
                .padding(.top, 12)
                HStack {
                    Text("Quantity").font(.system(size: 15, weight: .medium)).foregroundStyle(Tokens.ink)
                    Spacer()
                    QuantityStepper(count: $quantity)
                }
                .padding(.top, 24)
                Spacer(minLength: 0)
                KettleButton(title: "Add to order · \(Money.format(drink.priceCents * quantity))", action: onAdd)
            }
        }
    }
}
