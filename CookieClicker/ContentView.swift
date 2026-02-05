//
//  ContentView.swift
//  CookieClicker
//
//  Created by Rens Aarts on 05/02/2026.
//

import SwiftUI

struct ContentView: View {
    @State var cookiesPerSecond: Int = 0
    @State var cookies: Int = 0

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Cookie Clicker!")
                Spacer()
                Button(action: {
                    cookies += 1
                }, label: {
                    Image("Cookie")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                })
                Text("Total Cookies: " + String(cookies))
                    .foregroundStyle(Color.white)
                    .fontWeight(.heavy)
                Spacer()
                HStack {
                    NavigationLink("Credits") {
                        CreditsView()
                    }.padding().background(Color.blue).foregroundStyle(Color.white).cornerRadius(10).fontWeight(Font.Weight.heavy)
                    NavigationLink("Shop") {
                        ShopView(cookiesPerSecond: $cookiesPerSecond, cookies: $cookies)
                    }.padding().background(Color.blue).foregroundStyle(Color.white).cornerRadius(10).fontWeight(Font.Weight.heavy)
                }
            }
            .padding()
            .background(Color.gray)
            .navigationTitle("Cookie Clicker")
        }
    }
}

#Preview {
    ContentView()
}
