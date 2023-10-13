//
//  SeedTests.swift
//  HD WalletTests
//
//  Created by R. Kukuh on 13/10/23.
//

import XCTest
@testable import HD_Wallet

final class SeedTests: XCTestCase {
    
    var seed: Seed!
    
    override func setUp() {
        super.setUp()
        
        seed = Seed()
    }
    
    override func tearDown() {
        seed = nil
        
        super.tearDown()
    }
    
    func testGenerate() {
        let mnemonic = "abandon ability able about above absent absorb abstract absurd abuse access"
        let passphrase = "TestPassphrase"
        let generatedSeed = try? seed.generate(from: mnemonic, with: passphrase)
        
        XCTAssertNotNil(generatedSeed)
    }
    
//    func testIsValidHex() {
//        let validHex = "abcd1234abcd1234abcd1234abcd1234abcd1234abcd1234abcd1234abcd1234"
//        XCTAssertTrue(Seed.isValidHex(of: validHex))
//        
//        let invalidHex = "ghijk"
//        XCTAssertFalse(Seed.isValidHex(of: invalidHex))
//    }
    
}
