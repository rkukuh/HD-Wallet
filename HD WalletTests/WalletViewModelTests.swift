//
//  WalletViewModelTests.swift
//  HD WalletTests
//
//  Created by R. Kukuh on 13/10/23.
//

import XCTest
@testable import HD_Wallet

final class WalletViewModelTests: XCTestCase {
    
    func testGenerateWallet() {
        let viewModel = WalletViewModel()
        
        viewModel.generateWallet()
        
        // Assuming successful generation, test the properties.
        XCTAssertFalse(viewModel.entropy.isEmpty)
        XCTAssertFalse(viewModel.seedPhrase.isEmpty)
        XCTAssertFalse(viewModel.seed.isEmpty)
        XCTAssertFalse(viewModel.masterPrivateKey.isEmpty)
        XCTAssertFalse(viewModel.chainCode.isEmpty)
    }
    
}
