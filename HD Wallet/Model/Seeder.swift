//
//  Seeder.swift
//  HD Wallet
//
//  Created by R. Kukuh on 28/09/23.
//

import Foundation
import CryptoSwift

struct Seeder {
    
    static func generate(from mnemonic: String, with passphrase: String) -> Data {
        let salt = "thesalt" + passphrase
        
        let seed = try! PKCS5.PBKDF2(password: mnemonic.bytes,
                                     salt: salt.bytes,
                                     iterations: 2048,
                                     keyLength: 64,
                                     variant: .sha2(.sha512)).calculate()
        
        return Data(seed)
    }
    
    static func splitSeed(_ seed: Data) -> (masterPrivateKey: Data, chainCode: Data) {
        let masterPrivateKey = seed.prefix(32)
        let chainCode = seed.suffix(32)
        
        return (masterPrivateKey, chainCode)
    }
}
