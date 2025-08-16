//  SavedOffersStore.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 02/15/2024.
//

import Foundation

extension SavedOffersStore {
    func syncFromRemote(userId: String, fs: FirestoreServiceType = FirestoreService()) async {
        if let remote = try? await fs.fetchSavedOfferIds(userId: userId) {
            await MainActor.run {
                ids = remote
                persist()
                objectWillChange.send()
            }
        }
    }

    func toggleRemote(userId: String, offerId: UUID, fs: FirestoreServiceType = FirestoreService()) async {
        if let newSet = try? await fs.toggleSavedOffer(userId: userId, offerId: offerId) {
            await MainActor.run {
                ids = newSet
                persist()
                objectWillChange.send()
            }
        }
    }
}
