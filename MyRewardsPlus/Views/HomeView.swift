//  HomeView.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 12/15/2024.
//
import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var appState: AppState
    @StateObject private var vm = HomeViewModel()

    // Keep anything non-view (like filtering/derivations) out of the ViewBuilder
    private var progressToNextTier: Double {
        let current = Double(appState.account.points)
        let target = Double(appState.account.nextTierPoints)
        guard target > 0 else { return 0 }
        return min(current / target, 1.0)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    PointsCard(
                        points: appState.account.points,
                        tier: appState.account.tier.rawValue,
                        progress: progressToNextTier
                    )
                    ExpiringPointsBanner(expiring: appState.account.expiringPoints)

                    SectionHeader("Recommended Offers")

                    if vm.isLoading {
                        ProgressView().padding()
                    } else if vm.offers.isEmpty {
                        EmptyState(text: "No offers today. Check back soon!")
                    } else {
                        ForEach(vm.offers) { offer in
                            OfferRow(
                                offer: offer,
                                isSaved: appState.savedOffers.contains(offer.id)
                            ) {
                                appState.toggleSavedOffer(offer.id)
                            }
                        }
                    }
                }
                .padding(16)
            }
            .navigationTitle("Road Rewards")
            .task { await vm.load() }
        }
    }
}
