//
//  Mnemonic.swift
//  HD Wallet
//
//  Created by R. Kukuh on 27/09/23.
//

import Foundation
import CryptoSwift

struct Mnemonic {
    
    static func convert(from entropy: Data, wordList: [String]) -> String {
        var mnemonic = ""
        
        for _ in 1..<24 {
            mnemonic += wordList[Int(arc4random_uniform(UInt32(wordList.count)))] + " "
        }
        
        return mnemonic.trimmingCharacters(in: .whitespaces)
    }
    
    static func generateSeed(from mnemonic: String, passphrase: String) -> Data {
        let salt = "thesalt" + passphrase
        
        let seed = try! PKCS5.PBKDF2(password: mnemonic.bytes,
                                     salt: salt.bytes,
                                     iterations: 2048,
                                     keyLength: 64, 
                                     variant: .sha2(.sha512)).calculate()
        
        return Data(seed)
    }
}
