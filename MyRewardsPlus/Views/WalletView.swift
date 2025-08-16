//  WalletView.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 12/15/2024.
//
import SwiftUI

struct WalletView: View {
    @EnvironmentObject private var appState: AppState
    @State private var offers: [Offer] = []
    @State private var loading = false
    let service: OffersServiceType = OffersService()

    // Compute saved offers outside the view builder to avoid `buildExpression` errors.
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
                        OfferRow(offer: offer, isSaved: true) {
                            if let uid = appState.userId {
                                Task { await appState.savedOffers.toggleRemote(userId: uid, offerId: offer.id) }
                            } else {
                                appState.toggleSavedOffer(offer.id)
                            }
                        }
                    }
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
