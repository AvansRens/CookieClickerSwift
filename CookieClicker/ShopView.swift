//
//  ShopView.swift
//  CookieClicker
//
//  Created by Rens Aarts on 05/02/2026.
//

import SwiftUI

struct ShopView: View {
    
    @Binding var cookiesPerSecond: Int
    @Binding var cookies: Int
    
    var body: some View {
        Spacer()
        HStack {
            Text("CPS: \(cookiesPerSecond)")
            Text("Total Cookies: \(cookies)")
        }
        Spacer()
        Button (
            action: {
                if(cookies >= 10) {
                    cookies -= 10
                }
            },
            label: {
                Text("Buy a grandma!")
            }
        )
        
    }
}

#Preview {
    ShopView(cookiesPerSecond: .constant(0), cookies: .constant(0))
}
