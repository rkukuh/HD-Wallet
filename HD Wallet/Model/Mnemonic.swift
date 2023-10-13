//
//  Mnemonic.swift
//  HD Wallet
//
//  Created by R. Kukuh on 27/09/23.
//

import Foundation

struct Mnemonic {
    
    func convert(from entropy: Data, using wordList: [String]) -> String {
        var mnemonic = ""
        
        for _ in 1..<24 {
            mnemonic += wordList[Int(arc4random_uniform(UInt32(wordList.count)))] + " "
        }
        
        return mnemonic.trimmingCharacters(in: .whitespaces)
    }
    
}
