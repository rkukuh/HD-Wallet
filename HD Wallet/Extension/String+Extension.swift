//
//  String+Extension.swift
//  HD Wallet
//
//  Created by R. Kukuh on 29/09/23.
//

import Foundation

extension String {
    func binaryToHex() -> String {
        var hexString = ""
        var startIndex = self.startIndex
        
        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: 8, limitedBy: self.endIndex) ?? self.endIndex
            
            let substring = self[startIndex..<endIndex]
            
            if let decimalValue = UInt8(String(substring), radix: 2) {
                hexString += String(format: "%02X ", decimalValue)
            }
            
            startIndex = endIndex
        }
        
        return hexString.trimmingCharacters(in: .whitespaces)
    }
    
    func truncateMiddle(to length: Int = 50, separator: String = "...") -> String {
        guard self.count > length else { return self }
        
        let prefixLength = Int(ceil(Double(length) / 2.0)) - (separator.count / 2)
        let suffixLength = Int(floor(Double(length) / 2.0)) - (separator.count / 2)
        
        let prefix = self.prefix(prefixLength)
        let suffix = self.suffix(suffixLength)
        
        return "\(prefix)\(separator)\(suffix)"
    }
}
