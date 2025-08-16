//  AppEntryView.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 12/15/2024.
//
import SwiftUI

struct AppEntryView: View {
    @EnvironmentObject private var appState: AppState
    var body: some View {
        Group {
            if appState.userId == nil {
                SignInView()
            } else {
                RootTabView()
            }
        }
    }
}
