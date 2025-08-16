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
                            // still show the state accurately (always true here, but harmless)
                            isSaved: appState.savedOffers.contains(offer.id)
                        ) {
                            // Optimistic toggle so the row disappears immediately
                            withAnimation {
                                appState.toggleSavedOffer(offer.id)
                            }
                        }
                    }
                    // Key the list by the saved count to ensure refresh after toggles
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
        }
    }
}
