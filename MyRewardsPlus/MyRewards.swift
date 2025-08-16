//  MyRewards.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 12/15/2024.
//
import SwiftUI

@main
struct MyRewards: App {
    @UIApplicationDelegateAdaptor(FirebaseAppDelegate.self) var firebase
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            AppEntryView()
                .environmentObject(appState)
                .tint(AppTheme.red)
                .background(AppTheme.grayBG)
        }
    }
}
