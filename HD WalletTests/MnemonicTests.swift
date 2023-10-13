//
//  MnemonicTests.swift
//  HD WalletTests
//
//  Created by R. Kukuh on 13/10/23.
//

import XCTest
@testable import HD_Wallet

final class MnemonicTests: XCTestCase {
    
    var mnemonic: Mnemonic!
    var bitcoin: Bitcoin!
    
    override func setUp() {
        super.setUp()
        
        mnemonic = Mnemonic()
        bitcoin = Bitcoin()
    }
    
    override func tearDown() {
        mnemonic = nil
        bitcoin = nil
        
        super.tearDown()
    }
    
    func testConvert() {
        let entropy = Data([UInt8](repeating: 0, count: 16)) // 128 bits of entropy
        let phrase = mnemonic.convert(from: entropy, using: bitcoin.BIP39WordList)
        
        let words = phrase.split(separator: " ")
        
        XCTAssertEqual(words.count, 24)  // 128 bits should yield a 24-words mnemonic
    }
    
}
