import SwiftUI
import Combine

@MainActor
final class GameState: ObservableObject {
    @Published private(set) var cookies: Int = 0
    @Published var items: [ShopItem]

    private var ticker: Task<Void, Never>?

    init() {
        self.items = [
            ShopItem(name: "Grandma", baseCost: 10, cps: 2),
            ShopItem(name: "Robot", baseCost: 100, cps: 15),
            ShopItem(name: "Farm", baseCost: 750, cps: 60),
            ShopItem(name: "Mine", baseCost: 3000, cps: 250)
        ]
    }

    var cookiesPerSecond: Int {
        items.reduce(0) { $0 + ($1.cps * $1.count) }
    }

    func tapCookie() {
        cookies += 1
    }

    func canAfford(_ item: ShopItem) -> Bool {
        cookies >= item.currentPrice
    }

    func purchase(itemID: UUID) {
        guard let index = items.firstIndex(where: { $0.id == itemID }) else { return }
        let price = items[index].currentPrice
        guard cookies >= price else { return }
        cookies -= price
        items[index].count += 1
        items[index].increasePrice()
    }

    func tick() {
        cookies += cookiesPerSecond
    }

    func startTicker() {
        guard ticker == nil else { return }
        ticker = Task { [weak self] in
            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                await self?.tick()
            }
        }
    }

    func stopTicker() {
        ticker?.cancel()
        ticker = nil
    }
}

struct ShopItem: Identifiable {
    let id = UUID()
    let name: String
    let baseCost: Int
    let cps: Int
    var count: Int = 0
    var currentPrice: Int
    var priceMultiplier: Double = 1.15

    init(name: String, baseCost: Int, cps: Int, priceMultiplier: Double = 1.15) {
        self.name = name
        self.baseCost = baseCost
        self.cps = cps
        self.priceMultiplier = priceMultiplier
        self.currentPrice = baseCost
    }

    mutating func increasePrice() {
        let newPrice = Int((Double(currentPrice) * priceMultiplier).rounded())
        currentPrice = max(newPrice, currentPrice + 1)
    }
}
