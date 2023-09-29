//
//  Data+Extension.swift
//  HD Wallet
//
//  Created by R. Kukuh on 29/09/23.
//

import Foundation

extension Data {
    
    func toBinaryString() -> String {
        return self.map { byte in
            String(byte, radix: 2).padding(toLength: 8, withPad: "0", startingAt: 0)
        }.joined()
    }
    
    func toHexString() -> String {
        return self.map { String(format: "%02x", $0) }.joined()
    }
}
