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

    let savedOffers = SavedOffersStore()
    @Published private(set) var savedOffersCount: Int = 0

    private var cancellables = Set<AnyCancellable>()

    init() {
        savedOffersCount = savedOffers.count
        savedOffers.objectWillChange
            .sink { [weak self] _ in
                self?.savedOffersCount = self?.savedOffers.count ?? 0
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)

        // Listen to Firebase auth state
        auth.listen { [weak self] uid in
                    Task { @MainActor in
                        self?.userId = uid
                        if let uid {
                            await self?.savedOffers.syncFromRemote(userId: uid)
                            self?.savedOffersCount = self?.savedOffers.count ?? 0
                        }
                    }
        }
    }

    func toggleSavedOffer(_ id: UUID) {
            if let uid = userId {
                Task { await savedOffers.toggleRemote(userId: uid, offerId: id) }
            } else {
                savedOffers.toggle(id)
            }
    }
}
