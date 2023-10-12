//
//  Entropy.swift
//  HD Wallet
//
//  Created by R. Kukuh on 27/09/23.
//

import Foundation

struct Entropy {
    
    func randomizeForBits(_ bits: Int) -> Data {
        var bytes = [UInt8](repeating: 0, count: bits / 8)
        
        let _ = SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)
        
        return Data(bytes)
    }
}
