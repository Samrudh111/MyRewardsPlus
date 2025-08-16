//  WalletView.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 12/18/2024.
//

import SwiftUI

struct WalletView: View {
    @EnvironmentObject private var appState: AppState
    @State private var offers: [Offer] = []
    @State private var loading = false
    let service: OffersServiceType = OffersService()

    // Filter saved offers based on current saved IDs
    private var savedOffersList: [Offer] {
        offers.filter { appState.savedOffers.contains($0.id) }
    }

    var body: some View {
        NavigationStack {
            Group {
                if loading {
                    ProgressView().padding()
                } else if savedOffersList.isEmpty {
                    EmptyState(text: "No saved offers yet.")
                } else {
                    List(savedOffersList) { offer in
                        OfferRow(
                            offer: offer,
                            isSaved: appState.savedOffers.contains(offer.id)
                        ) {
                            withAnimation {
                                appState.toggleSavedOffer(offer.id)
                            }
                        }
                    }
                    .id(appState.savedOffersCount)
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Wallet")
            .task {
                loading = true
                offers = (try? await service.fetchOffers()) ?? []
                loading = false
            }
            .background(AppTheme.grayBG.ignoresSafeArea())
        }
    }
}
