//  AppState.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 12/15/2024.
//
import SwiftUI
import Combine

final class AppState: ObservableObject {
    // Sample account for UI; replace with profile fetch if desired
    @Published var account = RewardAccount.sample

    // Auth/session
    @Published var userId: String? = nil
    let auth: AuthServiceType = AuthService()

    // Saved offers (local cache + remote sync)
    let savedOffers = SavedOffersStore()
    @Published private(set) var savedOffersCount: Int = 0  // convenient for .badge()

    private var cancellables = Set<AnyCancellable>()

    init() {
        // Keep badge/count in sync and forward nested store changes
        savedOffers.objectWillChange
            .sink { [weak self] _ in
                guard let self else { return }
                self.savedOffersCount = self.savedOffers.count
                self.objectWillChange.send() // forward to views observing AppState
            }
            .store(in: &cancellables)

        savedOffersCount = savedOffers.count

        // Listen for auth state changes and sync saved offers when signed in
        auth.listen { [weak self] uid in
            guard let self else { return }
            Task { @MainActor in
                self.userId = uid
                if let uid {
                    await self.savedOffers.syncFromRemote(userId: uid)
                    self.savedOffersCount = self.savedOffers.count
                }
            }
        }
    }

    /// Toggle save state for an offer. Uses Firestore if signed in, local cache otherwise.
    func toggleSavedOffer(_ id: UUID) {
        if let uid = userId {
            Task { await savedOffers.toggleRemote(userId: uid, offerId: id) }
        } else {
            savedOffers.toggle(id)
        }
    }
}
