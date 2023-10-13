//
//  BitcoinTests.swift
//  HD WalletTests
//
//  Created by R. Kukuh on 13/10/23.
//

import XCTest
@testable import HD_Wallet

final class BitcoinTests: XCTestCase {
    
    func testBIP39WordList() {
        let bitcoin = Bitcoin()
        
        // Assuming the word list should have 2048 words as per BIP-39 spec.
        XCTAssertEqual(bitcoin.BIP39WordList.count, 2048)
    }
    
}
