//
//  EntropyTests.swift
//  HD WalletTests
//
//  Created by R. Kukuh on 13/10/23.
//

import XCTest
@testable import HD_Wallet

final class EntropyTests: XCTestCase {
    
    func testRandomizeForBits() {
        let entropy = Entropy()
        let data = entropy.randomizeForBits(128)
        
        XCTAssertEqual(data.count, 16)  // 128 bits should yield 16 bytes.
    }
    
}
