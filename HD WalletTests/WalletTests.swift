//
//  WalletTests.swift
//  HD WalletTests
//
//  Created by R. Kukuh on 13/10/23.
//

import XCTest
@testable import HD_Wallet

final class WalletTests: XCTestCase {
    
    var wallet: Wallet!
    
    override func setUp() {
        super.setUp()
        
        wallet = Wallet()
    }
    
    override func tearDown() {
        wallet = nil
        
        super.tearDown()
    }
    
    func testCreateMasterKey() {
        let seed = Data([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        
        do {
            let keys = try wallet.createMasterKey(from: seed)
            
            XCTAssertNotNil(keys.privateKey)
            XCTAssertNotNil(keys.chainCode)
        } catch {
            XCTFail("Failed to create master key: \(error)")
        }
    }
    
    func testDeriveChildKey() {
        let masterKey = Data([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        let chainCode = Data([10, 11, 12, 13, 14, 15, 16, 17, 18, 19])
        let childKey = wallet.deriveChildKey(from: masterKey, with: chainCode, index: 0)
        
        XCTAssertNotNil(childKey)
    }
    
//    func testCreatePublicKey() {
//        let privateKey = Data([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
//        let publicKey = wallet.createPublicKey(from: privateKey)
//        
//        XCTAssertNotNil(publicKey)
//    }
    
    func testCreatePublicAddress() {
        let publicKey = Data([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        let publicAddress = wallet.createPublicAddress(for: publicKey)
        
        XCTAssertNotNil(publicAddress)
    }
    
}
