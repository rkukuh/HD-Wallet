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
    
    @State private var privateKey: Data = .init()
    @State private var chainCode: Data = .init()
    
    // MARK: Step 3: Optional Password (Salt)
    let passphrase = "b1gs3cr3t"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                // MARK: Step 1: Generate Entropy
                
                VStack(alignment: .leading) {
                    Label("Entropy", systemImage: "sparkle")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 5)
                    
                    Text("\(entropy.toBinaryString().binaryToHex())")
                        .frame(height: 50)
                        .truncationMode(.middle)
                }
                .padding()
                .border(.red)
                
                // MARK: Step 2: Convert Entropy to Mnemonic Seed Phrase
                
                VStack(alignment: .leading) {
                    Label("Seed Phrase", systemImage: "text.book.closed")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 5)
                    
                    Text(seedPhrase)
                        .frame(height: 50)
                        .truncationMode(.middle)
                }
                .padding()
                .border(.red)
                
                // MARK: Step 4: Generate Seed from Seed Phrase
                
                VStack(alignment: .leading) {
                    HStack {
                        Label("Seed", systemImage: "leaf.arrow.circlepath")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 5)
                        
                        if Seeder.isValidHex(of: seed.toHexString()) {
                            Text("Valid")
                                .frame(width: 65)
                                .foregroundColor(.green)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.green)
                                )
                                .padding(.bottom, 5)
                        } else {
                            Text("Tempered")
                                .frame(width: 100)
                                .foregroundColor(.red)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.red)
                                )
                                .padding(.bottom, 5)
                        }
                    }
                    
                    Text("\(seed.toHexString())")
                        .frame(height: 50)
                        .truncationMode(.middle)
                }
                .padding()
                .border(.red)
                
                Spacer()
                
                // MARK: Step 5: Generate HD Wallet
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Label("Private Key (Master)", systemImage: "key.fill")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 5)
                        
                        Text("\(privateKey.toHexString())")
                            .frame(height: 50)
                            .truncationMode(.middle)
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Label("Chain Code", systemImage: "link")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 5)
                        
                        Text("\(chainCode.toHexString())")
                            .frame(height: 50)
                            .truncationMode(.middle)
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
                
                (privateKey, chainCode) = Key.generateMasterKey(from: seed)
            }
            .navigationTitle("HD Wallet")
        }
    }
}

#Preview {
    ContentView()
}
