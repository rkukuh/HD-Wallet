//
//  ContentView.swift
//  HD Wallet
//
//  Created by R. Kukuh on 27/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var entropy: Data = .init()
    @State private var seedPhrase: String = .init()
    @State private var seed: Data = .init()
    
    @State private var masterPrivateKey: Data = .init()
    @State private var chainCode: Data = .init()
    
    // MARK: Step 3: Optional Password (Salt)
    let passphrase = "b1gs3cr3t"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                // MARK: Step 1: Generate Entropy
                
                VStack(alignment: .leading) {
                    Text("Entropy")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 5)
                    
                    Text("\(entropy.toBinaryString())")
                        .frame(height: 50)
                        .truncationMode(.tail)
                }
                .padding()
                .border(.red)
                
                // MARK: Step 2: Convert Entropy to Mnemonic Seed Phrase
                
                VStack(alignment: .leading) {
                    Text("Seed Phrase")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 5)
                    
                    Text(seedPhrase)
                }
                .padding()
                .border(.red)
                
                // MARK: Step 4: Generate Seed from Seed Phrase
                
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
                
                // MARK: Step 5: Generate HD Wallet
                
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
                
                // MARK: Step 6: Generate Private Key and Public Key
                
                // Step 5 code goes here...
            }
            .onAppear {
                entropy = Entropy.generate(for: 128)
                
                seedPhrase = Mnemonic.convert(from: entropy, wordList: Bitcoin.BIP39WordList)
                
                seed = Seeder.generate(from: seedPhrase, with: passphrase)
                
                (masterPrivateKey, chainCode) = Seeder.splitSeed(seed)
            }
            .navigationTitle("HD Wallet")
        }
    }
}

#Preview {
    ContentView()
}
