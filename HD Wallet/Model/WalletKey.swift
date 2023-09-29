//
//  Key.swift
//  HD Wallet
//
//  Created by R. Kukuh on 28/09/23.
//

import Foundation
import CryptoSwift
import CryptoKit

struct WalletKey {
    
    static func generateMasterKey(from seed: Data) -> (privateKey: Data, chainCode: Data) {
        let hmac = try! HMAC(key: seed.bytes, variant: .sha2(.sha512))
            .authenticate(seed.bytes)
        
        let privateKey = Data(hmac[0..<32])
        let chainCode = Data(hmac[32..<64])
        
        return (privateKey, chainCode)
    }
    
    static func generateChildKey(from masterKey: Data, with chainCode: Data, index: UInt32) -> Data {
        var key = masterKey
        
        key.append(contentsOf: withUnsafeBytes(of: index.bigEndian) { Data($0) })
        
        let hmacKey: Array<UInt8> = Array(chainCode)
        
        let childHash = try! HMAC(key: hmacKey, variant: .sha2(.sha512))
            .authenticate(Array(key))
        
        return Data(childHash.prefix(32))
    }
    
    static func generatePublicKey(from privateKey: Data) -> Data? {
        do {
            let privateKey = try P256.Signing.PrivateKey(rawRepresentation: privateKey)
            
            return privateKey.publicKey.rawRepresentation
        } catch {
            print("Error generating public key: \(error.localizedDescription)")
            
            return nil
        }
    }
}
