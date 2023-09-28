//
//  Key.swift
//  HD Wallet
//
//  Created by R. Kukuh on 28/09/23.
//

import Foundation
import CryptoKit

struct Key {
    
    static func generateChildPrivateKey(for masterPrivateKey: Data, 
                                        with chainCode: Data, index: UInt32) -> Data {
        
        var data = masterPrivateKey
        
        data.append(contentsOf: withUnsafeBytes(of: index.bigEndian) { Data($0) })
        
        let hmacKey = SymmetricKey(data: chainCode)
        let childHash = HMAC<SHA512>.authenticationCode(for: data, using: hmacKey)
        let childPrivateKey = Data(childHash.prefix(32))
        
        return childPrivateKey
    }
}
