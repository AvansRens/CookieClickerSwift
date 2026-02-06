import SwiftUI

struct ContentView: View {
    @StateObject private var game = GameState()
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Cookie Clicker!")
                Spacer()
                Button(action: {
                    game.tapCookie()
                }, label: {
                    Image("Cookie")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                })
                Text("Total Cookies: " + String(game.cookies))
                    .foregroundStyle(Color.white)
                    .fontWeight(.heavy)
                Spacer()
                HStack {
                    NavigationLink("Credits") {
                        CreditsView()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(Color.white)
                    .cornerRadius(10)
                    .fontWeight(Font.Weight.heavy)

                    NavigationLink("Shop") {
                        ShopView()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(Color.white)
                    .cornerRadius(10)
                    .fontWeight(Font.Weight.heavy)
                }
            }
            .padding()
            .background(Color.gray)
            .navigationTitle("Cookie Clicker")
        }
        .environmentObject(game)
        .onChange(of: scenePhase, initial: true) { _, newPhase in
            switch newPhase {
            case .active:
                game.startTicker()
            case .inactive, .background:
                game.stopTicker()
            @unknown default:
                break
            }
        }
    }
}

#Preview {
    ContentView()
}
