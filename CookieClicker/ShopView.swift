import SwiftUI

struct ShopView: View {

    @EnvironmentObject var game: GameState

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("CPS: \(game.cookiesPerSecond)")
                Spacer()
                Text("Total Cookies: \(game.cookies)")
            }
            .font(.headline)
            .padding(.horizontal)

            List {
                ForEach(game.items) { item in
                    ShopRow(
                        item: item,
                        canAfford: game.canAfford(item),
                        buyAction: { game.purchase(itemID: item.id) }
                    )
                }
            }
            .listStyle(.insetGrouped)
        }
    }
}

private struct ShopRow: View {
    let item: ShopItem
    let canAfford: Bool
    let buyAction: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                Text("CPS: \(item.cps) • Owned: \(item.count)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 6) {
                Text("Price: \(item.currentPrice)")
                    .monospacedDigit()
                Button("Buy") {
                    buyAction()
                }
                .buttonStyle(.borderedProminent)
                .disabled(!canAfford)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ShopView()
        .environmentObject(GameState())
}
