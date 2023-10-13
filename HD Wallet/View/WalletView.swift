//
//  ContentView.swift
//  HD Wallet
//
//  Created by R. Kukuh on 27/09/23.
//

import SwiftUI

struct WalletView: View {
    
    @ObservedObject var viewModel: WalletViewModel
    
    @State private var entropy: Data = .init()
    @State private var seed: Data = .init()
    @State private var masterPrivateKey: Data = .init()
    @State private var chainCode: Data = .init()
    @State private var wallet: Wallet = .init()
    
    init(viewModel: WalletViewModel) {
        self.viewModel = WalletViewModel()
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // MARK: Step 1: Create Entropy
                
                VStack(alignment: .leading) {
                    HeadingLabel(title: "Entropy", icon: "sparkle")
                    
                    Text("\(entropy.toBinaryString().binaryToHex())")
                        .frame(height: 50)
                        .truncationMode(.middle)
                }
                .padding()
                
                // MARK: Step 2: Convert Entropy to Mnemonic Seed Phrase
                
                VStack(alignment: .leading) {
                    HeadingLabel(title: "Seed Phrase", icon: "text.book.closed")
                    
                    Text(viewModel.seedPhrase)
                }
                .padding()
                
                // MARK: Step 3: Generate Seed from Seed Phrase
                
                VStack(alignment: .leading) {
                    HStack {
                        HeadingLabel(title: "Seed", icon: "leaf.arrow.circlepath")
                        
                        if Seed.isValidHex(of: seed.toHexString()) {
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
                
                // MARK: Step 4: Create The Wallet
                
                Label("Crypto Wallet", systemImage: "wallet.pass")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .padding(.top, 10)
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        HeadingLabel(title: "Private Key (Master)", icon: "key.fill")
                        
                        Text("\(masterPrivateKey.toHexString())")
                    }
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        HeadingLabel(title: "Chain Code", icon: "link")
                        
                        Text("\(chainCode.toHexString())")
                    }
                }
                .frame(height: 100)
                .truncationMode(.middle)
                .padding()
                
                Text("Created 5 addresses for the same wallet")
                    .frame(width: 350, height: 70)
                    .foregroundColor(.blue)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.blue)
                    )
            }
            .onAppear {
                viewModel.generateWallet()
                
                entropy = viewModel.entropy
                seed = viewModel.seed
                masterPrivateKey = viewModel.masterPrivateKey
                chainCode = viewModel.chainCode
                
                // MARK: Step 5: Create (Child) Private Key and Public Key
                // MARK: Step 6: Create Wallet's Public Address
                
                wallet = viewModel.wallet
                
                for index in 1...5 {
                    let childPrivateKey = wallet.deriveChildKey(from: masterPrivateKey,
                                                                with: chainCode,
                                                                index: UInt32(index))
                    
                    let publicKey = wallet.createPublicKey(from: childPrivateKey)
                    let publicAddress = wallet.createPublicAddress(for: publicKey)
                    
                    print("Child No. #\(index)")
                    print("Private Key: \t \(childPrivateKey.toHexString())")
                    print("Public Key: \t \(publicKey.toHexString().truncateMiddle())")
                    print("Address: \t\t \(publicAddress)")
                    print()
                }
            }
            .navigationTitle("HD Wallet")
        }
    }
    
}

#Preview {
    WalletView(viewModel: WalletViewModel())
}
