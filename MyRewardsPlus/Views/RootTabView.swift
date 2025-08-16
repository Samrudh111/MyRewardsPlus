//  RootTabView.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 12/15/2024.
//
import SwiftUI

struct RootTabView: View {
    @EnvironmentObject private var appState: AppState
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "star.circle.fill") }
            LocationsView()
                .tabItem { Label("Locations", systemImage: "map.fill") }
            FuelPayView()
                .tabItem { Label("Fuel Pay", systemImage: "fuelpump.fill") }
            WalletView()
                .tabItem { Label("Wallet", systemImage: "wallet.pass.fill") }
                .badge(appState.savedOffers.count)
            AccountView()
                .tabItem { Label("Account", systemImage: "person.crop.circle") }
        }
    }
}
