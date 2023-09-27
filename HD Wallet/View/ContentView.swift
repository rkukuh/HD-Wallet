//
//  ContentView.swift
//  HD Wallet
//
//  Created by R. Kukuh on 27/09/23.
//

import SwiftUI

struct ContentView: View {
    let entropy = Entropy.generate(from: 256)
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Entropy")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 5)
                
                Text("\(entropy)")
            }
            .padding()
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("Mnemonic")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 5)
                
                Text(Mnemonic.convert(from: entropy, wordList: Bitcoin.BIP39WordList))
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
