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
                    Label("Entropy", systemImage: "sparkle")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 5)
                    
                    Text("\(entropy.toBinaryString().binaryToHex())")
                        .frame(height: 50)
                        .truncationMode(.middle)
                }
                .padding()
                
                // MARK: Step 2: Convert Entropy to Mnemonic Seed Phrase
                
                VStack(alignment: .leading) {
                    Label("Seed Phrase", systemImage: "text.book.closed")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 5)
                    
                    Text(seedPhrase)
                }
                .padding()
                
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
                
                Divider()
                
                // MARK: Step 5: Generate HD Wallet
                
                Label("Crypto Wallet", systemImage: "wallet.pass")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .padding(.top, 10)
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Label("Private Key (Master)", systemImage: "key.fill")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 5)
                        
                        Text("\(masterPrivateKey.toHexString())")
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Label("Chain Code", systemImage: "link")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 5)
                        
                        Text("\(chainCode.toHexString())")
                    }
                }
                .frame(height: 100)
                .truncationMode(.middle)
                .padding()
                
                // MARK: Step 6: Generate (Child) Private Key and Public Key
                
                // Take a look at the Console
                
                Text("Successfully created 5 addresses for the same wallet")
                    .frame(width: 350, height: 70)
                    .foregroundColor(.blue)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.blue)
                    )
            }
            .onAppear {
                entropy = Entropy.generate(for: 256)
                
                seedPhrase = Mnemonic.convert(from: entropy, using: Bitcoin.BIP39WordList)
                
                seed = Seeder.generate(from: seedPhrase, with: passphrase)
                
                (masterPrivateKey, chainCode) = WalletKey.generateMasterKey(from: seed)
                
                for index in 1...5 {
                    let childPrivateKey = WalletKey.generateChildKey(from: masterPrivateKey, with: chainCode, index: UInt32(index))
                    
                    let publicKey = WalletKey.generatePublicKey(from: childPrivateKey)
                    let publicAddress = WalletKey.generatePublicAddress(publicKey: publicKey)
                    
                    print("Wallet No. #\(index)")
                    print("PrivKey: \t \(childPrivateKey.toHexString())")
                    print("PubKey: \t \(publicKey.toHexString().truncateMiddle(to: 100))")
                    print("Address: \t \(publicAddress)")
                    print()
                    
                }
            }
            .navigationTitle("HD Wallet")
        }
    }
}

#Preview {
    ContentView()
}
