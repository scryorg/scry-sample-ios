import SwiftUI

struct OrderView: View {
    let order: Order
    var onAddMore: () -> Void = {}
    var onPlaceOrder: () -> Void = {}

    var body: some View {
        ScreenFrame {
            VStack(alignment: .leading, spacing: 0) {
                Text("Your order").font(.system(size: 28, weight: .bold)).foregroundStyle(Tokens.ink)
                Text("Pickup at Kettle on 5th St · ready in 8 min")
                    .font(.system(size: 15)).foregroundStyle(Tokens.muted)
                    .padding(.top, 4)
                VStack(spacing: 0) {
                    ForEach(Array(order.lines.enumerated()), id: \.offset) { index, line in
                        if index > 0 { Rectangle().fill(Tokens.line).frame(height: 1) }
                        HStack(spacing: 8) {
                            Text(line.drink.name).font(.system(size: 16, weight: .semibold)).foregroundStyle(Tokens.ink)
                            Text("×\(line.quantity)").font(.system(size: 15)).foregroundStyle(Tokens.muted)
                            Spacer()
                            Text(Money.format(line.drink.priceCents * line.quantity))
                                .font(.system(size: 15, weight: .semibold)).foregroundStyle(Tokens.ink)
                        }
                        .frame(height: 56)
                    }
                }
                .padding(.horizontal, 16)
                .background(Tokens.surface)
                .clipShape(RoundedRectangle(cornerRadius: Tokens.Radius.card))
                .overlay(RoundedRectangle(cornerRadius: Tokens.Radius.card).strokeBorder(Tokens.line, lineWidth: 1))
                .padding(.top, 24)
                VStack(spacing: 0) {
                    totalsRow("Subtotal", Money.format(order.subtotalCents))
                    totalsRow("Tax", Money.format(order.taxCents))
                    HStack {
                        Text("Total").font(.system(size: 17, weight: .bold))
                        Spacer()
                        Text(Money.format(order.totalCents)).font(.system(size: 17, weight: .bold))
                    }
                    .foregroundStyle(Tokens.ink)
                    .frame(height: 28)
                }
                .padding(.top, 12)
                Spacer(minLength: 0)
                KettleButton(title: "Add more", style: .secondary, action: onAddMore)
                KettleButton(title: "Place order", action: onPlaceOrder).padding(.top, 12)
            }
        }
    }

    private func totalsRow(_ label: String, _ value: String) -> some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
        }
        .font(.system(size: 15))
        .foregroundStyle(Tokens.muted)
        .frame(height: 28)
    }
}
