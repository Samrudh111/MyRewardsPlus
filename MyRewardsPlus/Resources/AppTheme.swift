//
//  AppTheme.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 01/13/25.
//

import SwiftUI

enum AppTheme {
    // Brand-inspired palette
    static let red       = Color(red: 0.78, green: 0.06, blue: 0.18)
    static let redDark   = Color(red: 0.63, green: 0.04, blue: 0.14)
    static let yellow    = Color(red: 1.00, green: 0.76, blue: 0.06)
    static let ink       = Color(red: 0.11, green: 0.11, blue: 0.12)   // near-black for text
    static let grayBG    = Color(white: 0.96)
    static let cardStroke = Color.black.opacity(0.06)

    // Gradients for hero/headers if desired
    static let heroGradient = LinearGradient(
        colors: [red, redDark],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

// Primary / Secondary button styles
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity)
            .background(configuration.isPressed ? AppTheme.redDark : AppTheme.red)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity)
            .background(.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(AppTheme.red, lineWidth: 1.5)
            )
            .foregroundColor(AppTheme.red)
    }
}
