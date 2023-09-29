//
//  Key.swift
//  HD Wallet
//
//  Created by R. Kukuh on 28/09/23.
//

import Foundation
import CryptoSwift

struct WalletKey {
    
    static func generateMasterKey(from seed: Data) -> (privateKey: Data, 
                                                       chainCode: Data) {
        let hmac = try! HMAC(key: seed.bytes, variant: .sha2(.sha512))
            .authenticate(seed.bytes)
        
        let privateKey = Data(hmac[0..<32])
        let chainCode = Data(hmac[32..<64])
        
        return (privateKey, chainCode)
    }
}
