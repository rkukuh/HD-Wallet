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
                            BadgeLabel(title: "Valid", color: .green)
                                .padding(.bottom, 5)
                        } else {
                            BadgeLabel(title: "Tempered", color: .red, frameWidth: 100)
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
                
                HeadingLabel(title: "Crypto Wallet", icon: "wallet.pass", textStyle: .headline)
                    .padding(.top, 10)
                    .padding(.bottom, -5)
                                
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
                // MARK: Step 5: Create (Child) Private Key and Public Key
                // MARK: Step 6: Create Wallet's Public Address
                
                generateWalletAndItsChild()
            }
            .navigationTitle("HD Wallet")
        }
    }
    
    private func generateWalletAndItsChild() {
        viewModel.generateWallet()
        
        entropy = viewModel.entropy
        seed = viewModel.seed
        masterPrivateKey = viewModel.masterPrivateKey
        chainCode = viewModel.chainCode
        
        wallet = viewModel.wallet
        
        for index in 1...5 {
            guard let childPrivateKey = wallet.deriveChildKey(from: masterPrivateKey,
                                                              with: chainCode,
                                                              index: UInt32(index)) else {
                print("Failed to derive child key")
                return
            }

            guard let publicKey = wallet.createPublicKey(from: childPrivateKey) else {
                print("Failed to create public key")
                return
            }

            let publicAddress = wallet.createPublicAddress(for: publicKey)

            print("Child No. #\(index)")
            print("Private Key: \t \(childPrivateKey.toHexString())")
            print("Public Key: \t \(publicKey.toHexString().truncateMiddle())")
            print("Address: \t\t \(publicAddress) \n")
        }
    }
}

#Preview {
    WalletView(viewModel: WalletViewModel())
}
