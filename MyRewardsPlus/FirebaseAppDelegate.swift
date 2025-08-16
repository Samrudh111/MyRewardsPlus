//  FirebaseAppDelegate.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 12/15/2024.
//
import SwiftUI
import FirebaseCore

final class FirebaseAppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
