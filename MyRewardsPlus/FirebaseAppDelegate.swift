//  FirebaseAppDelegate.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 02/27/2025.
//
import UIKit
import FirebaseCore

final class FirebaseAppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
