//
//  Seeder.swift
//  HD Wallet
//
//  Created by R. Kukuh on 28/09/23.
//

import Foundation
import CryptoSwift

enum SeedGenerationError: Error {
    case keyGenerationFailed
}

struct Seed {
    
    func generate(from mnemonic: String, with passphrase: String) throws -> Data? {
        let salt = "thesalt" + passphrase
        
        do {
            let seed = try PKCS5.PBKDF2(password: mnemonic.bytes,
                                        salt: salt.bytes,
                                        iterations: 2048,
                                        keyLength: 64,
                                        variant: .sha2(.sha512)).calculate()
            return Data(seed)
        } catch {
            throw SeedGenerationError.keyGenerationFailed
        }
    }
    
    static func isValidHex(of seedInHexFormat: String) -> Bool {
        let validHexCharacters = CharacterSet(charactersIn: "0123456789abcdefABCDEF")
        let seedCharacterSet = CharacterSet(charactersIn: seedInHexFormat)
        
        return seedInHexFormat.count == 128 && validHexCharacters.isSuperset(of: seedCharacterSet)
    }
    
}
