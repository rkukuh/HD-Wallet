//
//  ContentView.swift
//  HD Wallet
//
//  Created by R. Kukuh on 27/09/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Entropy")
                Spacer()
                Text("\(Entropy.generate(from: 128))")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
