import SwiftUI

struct MenuView: View {
    let drinks: [Drink]
    let itemCount: Int
    var onSelect: (Drink) -> Void = { _ in }
    var onViewOrder: () -> Void = {}

    var body: some View {
        ScreenFrame {
            VStack(alignment: .leading, spacing: 0) {
                Text("Menu").font(.system(size: 28, weight: .bold)).foregroundStyle(Tokens.ink)
                Text("Order ahead, skip the line")
                    .font(.system(size: 15)).foregroundStyle(Tokens.muted)
                    .padding(.top, 4)
                VStack(spacing: 12) {
                    ForEach(drinks) { drink in
                        Button { onSelect(drink) } label: { MenuItemRow(drink: drink) }
                            .buttonStyle(.plain)
                    }
                }
                .padding(.top, 24)
                Spacer(minLength: 0)
                KettleButton(title: "View order · \(itemCount) items", action: onViewOrder)
            }
        }
    }
}
