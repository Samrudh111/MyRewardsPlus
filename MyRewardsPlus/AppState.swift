//  AppState.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 12/20/2024.
//

import SwiftUI
import Combine

final class AppState: ObservableObject {
    @Published var account = RewardAccount.sample

    // Auth/session
    @Published var userId: String? = nil
    let auth: AuthServiceType = AuthService()

    // If you already have SavedOffersStore, keep it:
    let savedOffers = SavedOffersStore()
    @Published private(set) var savedOffersCount: Int = 0

    private var cancellables = Set<AnyCancellable>()

    init() {
        // Forward saved-offers changes for tab badge (optional)
        savedOffers.objectWillChange
            .sink { [weak self] _ in
                self?.savedOffersCount = self?.savedOffers.count ?? 0
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
        savedOffersCount = savedOffers.count

        // Listen to Firebase auth state
        auth.listen { [weak self] uid in
            Task { @MainActor in self?.userId = uid }
        }
    }

    // Convenience for OfferRow buttons (local only in this simple setup)
    func toggleSavedOffer(_ id: UUID) {
        savedOffers.toggle(id)
    }
}
