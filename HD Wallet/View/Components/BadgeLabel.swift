//
//  BadgeLabel.swift
//  HD Wallet
//
//  Created by R. Kukuh on 13/10/23.
//

import SwiftUI

struct BadgeLabel: View {
    
    let title: String
    let color: Color
    let frameWidth: Double
    
    init(title: String, color: Color) {
        self.title = title
        self.color = color
        frameWidth = 65
    }
    
    init(title: String, color: Color, frameWidth: Double) {
        self.title = title
        self.color = color
        self.frameWidth = frameWidth
    }
    
    var body: some View {
        Text(title)
            .frame(width: frameWidth)
            .foregroundColor(color)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(color)
            )
    }
}

#Preview {
    BadgeLabel(title: "General", color: .gray, frameWidth: 85)
        .previewLayout(.sizeThatFits)
}
