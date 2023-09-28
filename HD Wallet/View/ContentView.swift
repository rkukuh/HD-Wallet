//
//  ContentView.swift
//  HD Wallet
//
//  Created by R. Kukuh on 27/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var entropy: Data = .init()
    @State private var mnemonic: String = .init()
    @State private var seed: Data = .init()
    
    let passphrase = "b1gs3cr3t"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Entropy")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 5)
                    
                    Text("\(entropy.toHexString())")
                        .onAppear {
                            entropy = Entropy.generate(from: 256)
                        }
                }
                .padding()
                .border(.red)
                
                VStack(alignment: .leading) {
                    Text("Mnemonic")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 5)
                    
                    Text(mnemonic)
                        .onAppear {
                            mnemonic = Mnemonic.convert(from: entropy, wordList: Bitcoin.BIP39WordList)
                        }
                }
                .padding()
                .border(.red)
                
                VStack(alignment: .leading) {
                    Text("Seed")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 5)
                    
                    Text("\(seed.toHexString())")
                        .onAppear {
                            seed = Seeder.generate(from: mnemonic, with: passphrase)
                        }
                }
                .padding()
                .border(.red)
                
                Spacer()
            }
            .navigationTitle("HD Wallet")
        }
    }
}

#Preview {
    ContentView()
}
