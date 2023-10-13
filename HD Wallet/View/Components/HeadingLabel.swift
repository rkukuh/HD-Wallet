//
//  HeadingLabel.swift
//  HD Wallet
//
//  Created by R. Kukuh on 12/10/23.
//

import SwiftUI

struct HeadingLabel: View {
    
    let title: String
    let icon: String
    let textStyle: Font
    let foregroundStyle: HierarchicalShapeStyle
    
    init(title: String, icon: String) {
        self.title = title
        self.icon = icon
        
        textStyle = .callout
        foregroundStyle = .secondary
    }
    
    init(title: String, icon: String, textStyle: Font) {
        self.title = title
        self.icon = icon
        self.textStyle = textStyle
        
        foregroundStyle = .secondary
    }
    
    var body: some View {
        Label(title, systemImage: icon)
            .font(textStyle)
            .foregroundStyle(foregroundStyle)
            .padding(.bottom, 5)
    }
    
}

#Preview {
    HeadingLabel(title: "Title", icon: "person")
        .previewLayout(.sizeThatFits)
}
