//
//  Key.swift
//  HD Wallet
//
//  Created by R. Kukuh on 28/09/23.
//

import Foundation
import CryptoSwift
import CryptoKit

enum MasterKeyCreationError: Error {
    case hmacAuthenticationFailed
}

struct Wallet {
    
    func createMasterKey(from seed: Data) throws -> (privateKey: Data, chainCode: Data) {
        do {
            let hmac = try HMAC(key: seed.bytes, variant: .sha2(.sha512))
                .authenticate(seed.bytes)
            
            let privateKey = Data(hmac[0..<32])
            let chainCode = Data(hmac[32..<64])
            
            return (privateKey, chainCode)
        } catch {
            throw MasterKeyCreationError.hmacAuthenticationFailed
        }
    }
    
    func deriveChildKey(from masterKey: Data, with chainCode: Data, index: UInt32) -> Data {
        var key = masterKey
        
        key.append(contentsOf: withUnsafeBytes(of: index.bigEndian) { Data($0) })
        
        let hmacKey: Array<UInt8> = Array(chainCode)
        
        let childHash = try! HMAC(key: hmacKey, variant: .sha2(.sha512))
            .authenticate(Array(key))
        
        return Data(childHash.prefix(32))
    }
    
    func createPublicKey(from privateKey: Data) -> Data {
        let privateKey = try! P256.Signing.PrivateKey(rawRepresentation: privateKey)
        
        return privateKey.publicKey.rawRepresentation
    }
    
    func createPublicAddress(for publicKey: Data) -> String {
        // Normally, we'd perform SHA-256, then RIPEMD-160, and then Base58Check encoding.
        // For demonstration, we'll return a base64 string.
        
        return publicKey.base64EncodedString()
    }
}
