//
//  HD_WalletApp.swift
//  HD Wallet
//
//  Created by R. Kukuh on 27/09/23.
//

import SwiftUI

@main
struct HD_WalletApp: App {
    var body: some Scene {
        WindowGroup {
            let vm = WalletViewModel()
            
            WalletView(viewModel: vm)
        }
    }
}
