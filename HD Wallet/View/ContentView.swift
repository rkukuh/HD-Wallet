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
    
    @State private var masterPrivateKey: Data = .init()
    @State private var chainCode: Data = .init()
    
    let passphrase = "b1gs3cr3t"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Entropy")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 5)
                    
                    Text("\(entropy)")
                }
                .padding()
                .border(.red)
                
                VStack(alignment: .leading) {
                    Text("Mnemonic")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 5)
                    
                    Text(mnemonic)
                }
                .padding()
                .border(.red)
                
                VStack(alignment: .leading) {
                    Text("Seed")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 5)
                    
                    Text("\(seed.base64EncodedString())")
                }
                .padding()
                .border(.red)
                
                Spacer()
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("PrivateKey")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 5)
                        
                        Text("\(masterPrivateKey.base64EncodedString())")
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Chain")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 5)
                        
                        Text("\(chainCode.base64EncodedString())")
                    }
                }
                .padding()
                .border(.red)
                
                Spacer()
            }
            .onAppear {
                entropy = Entropy.generate(from: 256)
                
                mnemonic = Mnemonic.convert(from: entropy, wordList: Bitcoin.BIP39WordList)
                
                seed = Seeder.generate(from: mnemonic, with: passphrase)
                
                (masterPrivateKey, chainCode) = Seeder.splitSeed(seed)
            }
            .navigationTitle("HD Wallet")
        }
    }
}

#Preview {
    ContentView()
}
