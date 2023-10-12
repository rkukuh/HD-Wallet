//
//  WalletViewModel.swift
//  HD Wallet
//
//  Created by R. Kukuh on 12/10/23.
//

import Foundation

class WalletViewModel: ObservableObject {
    @Published var entropy: Data = .init()
    @Published var seedPhrase: String = .init()
    @Published var seed: Data = .init()
    @Published var masterPrivateKey: Data = .init()
    @Published var chainCode: Data = .init()
    
    let passphrase = "b1gs3cr3t"
    let bitcoin = Bitcoin()
    let entropyGenerator = Entropy()
    let mnemonic = Mnemonic()
    let seedGenerator = Seed()
    let wallet = Wallet()
    
    func generateWallet() {
        self.entropy = self.entropyGenerator.randomizeForBits(256)
        
        self.seedPhrase = self.mnemonic.convert(from: self.entropy, using: self.bitcoin.BIP39WordList)
        
        self.seed = try! self.seedGenerator.generate(from: self.seedPhrase, with: self.passphrase)
        
        (self.masterPrivateKey, self.chainCode) = try! self.wallet.createMasterKey(from: self.seed)
    }
}
