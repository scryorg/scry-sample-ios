import SwiftUI

/// The real app: Menu -> Item Detail -> Order, all from fixed data (no network, no sign-in).
struct RootView: View {
    enum Route: Equatable {
        case menu
        case detail(Drink)
        case order
    }

    @State private var route: Route = .menu
    @State private var order = Fixtures.order
    @State private var quantity = 1

    var body: some View {
        switch route {
        case .menu:
            MenuView(
                drinks: Fixtures.drinks,
                itemCount: order.itemCount,
                onSelect: { quantity = 1; route = .detail($0) },
                onViewOrder: { route = .order }
            )
        case .detail(let drink):
            ItemDetailView(
                drink: drink,
                quantity: $quantity,
                onBack: { route = .menu },
                onAdd: { order.add(drink, quantity: quantity); route = .menu }
            )
        case .order:
            OrderView(order: order, onAddMore: { route = .menu }, onPlaceOrder: { route = .menu })
        }
    }
}
