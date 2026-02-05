//
//  CreditsView.swift
//  CookieClicker
//
//  Created by Rens Aarts on 05/02/2026.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        VStack {
            Text("Rens made this!")
            Text("Datum van vandaag: " + Date().formatted(date: .long, time: .omitted))
        }
        .padding()
    }
}

#Preview {
    CreditsView()
}
