//  AccountView.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 12/15/2024.
//
import SwiftUI

struct AccountView: View {
    @EnvironmentObject private var appState: AppState
    @AppStorage("notificationsEnabled") private var notifications = true
    @State private var showQR = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Membership") {
                    HStack {
                        AvatarCircle(initials: initials(appState.account.memberName))
                        VStack(alignment: .leading) {
                            Text(appState.account.memberName).bold()
                            Text(appState.account.tier.rawValue + " Member").foregroundStyle(.secondary)
                        }
                        Spacer()
                        Button { showQR = true } label: {
                            Label("Loyalty Code", systemImage: "qrcode")
                        }
                        .buttonStyle(.bordered)
                    }
                    LabeledContent("Points", value: "\(appState.account.points)")
                    LabeledContent("Next Tier", value: "\(appState.account.nextTierPoints) pts")
                }

                Section("Preferences") {
                    Toggle("Notifications", isOn: $notifications)
                }

                Section {
                    Button(role: .destructive) { } label: { Text("Sign Out") }
                }
            }
            .navigationTitle("Account")
            .sheet(isPresented: $showQR) {
                LoyaltyCodeSheet(code: appState.account.loyaltyNumber)
            }
        }
    }

    private func initials(_ name: String) -> String {
        let comps = name.split(separator: " ")
        return comps.prefix(2).compactMap { $0.first }.map(String.init).joined()
    }
}
