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
    
    func deriveChildKey(from masterKey: Data, with chainCode: Data, index: UInt32) -> Data? {
        var key = masterKey
        
        key.append(contentsOf: withUnsafeBytes(of: index.bigEndian) { Data($0) })
        
        let hmacKey: Array<UInt8> = Array(chainCode)
        
        do {
            let childHash = try HMAC(key: hmacKey,
                                     variant: .sha2(.sha512)).authenticate(Array(key))
            
            return Data(childHash.prefix(32))
        } catch {
            print("Failed to derive child key: \(error)")
            
            return nil
        }
    }
    
    func createPublicKey(from privateKey: Data) -> Data? {
        do {
            let privateKeyInstance = try P256.Signing.PrivateKey(rawRepresentation: privateKey)
            
            return privateKeyInstance.publicKey.rawRepresentation
        } catch {
            print("Failed to create public key: \(error)")
            
            return nil
        }
    }
    
    func createPublicAddress(for publicKey: Data) -> String {
        // For demonstration, we'll return a base64 string.
        
        return publicKey.base64EncodedString()
    }
    
}
