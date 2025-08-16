//  FirestoreService.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 12/15/2024.
//
// FirestoreService.swift
// Uses FirebaseCore + FirebaseFirestore (no FirebaseFirestoreSwift)

import Foundation
import FirebaseFirestore

protocol FirestoreServiceType {
    func fetchOffers() async throws -> [Offer]
    func fetchSavedOfferIds(userId: String) async throws -> Set<UUID>
    func toggleSavedOffer(userId: String, offerId: UUID) async throws -> Set<UUID>
}

final class FirestoreService: FirestoreServiceType {
    private let db = Firestore.firestore()

    // MARK: - Offers

    /// Expects a collection "offers" with fields:
    /// title:String, detail:String, pointsBonus:Number, expiresOn:Timestamp
    func fetchOffers() async throws -> [Offer] {
        let snapshot = try await db.collection("offers").getDocuments()
        var results: [Offer] = []
        results.reserveCapacity(snapshot.documents.count)

        for doc in snapshot.documents {
            let data = doc.data()
            guard
                let title = data["title"] as? String,
                let detail = data["detail"] as? String,
                let points = data["pointsBonus"] as? Int,
                let ts = data["expiresOn"] as? Timestamp
            else { continue }

            // Use the Firestore doc ID if it parses as UUID; otherwise generate one
            let id = UUID(uuidString: doc.documentID) ?? UUID()
            results.append(
                Offer(
                    id: id,
                    title: title,
                    detail: detail,
                    pointsBonus: points,
                    expiresOn: ts.dateValue()
                )
            )
        }
        return results
    }

    // MARK: - Saved Offers (users/{uid}.savedOffers: [String UUIDs])

    func fetchSavedOfferIds(userId: String) async throws -> Set<UUID> {
        let ref = db.collection("users").document(userId)
        let doc = try await ref.getDocument()
        guard let arr = doc.data()?["savedOffers"] as? [String] else { return [] }
        return Set(arr.compactMap(UUID.init(uuidString:)))
    }

    /// Atomically add/remove the offer ID using arrayUnion/arrayRemove, then return the final set.
    func toggleSavedOffer(userId: String, offerId: UUID) async throws -> Set<UUID> {
        let ref = db.collection("users").document(userId)
        let idStr = offerId.uuidString

        // Read current state to decide add/remove
        let snap = try await ref.getDocument()
        let current = (snap.data()?["savedOffers"] as? [String]) ?? []

        if current.contains(idStr) {
            // Remove
            try await ref.setData(["savedOffers": FieldValue.arrayRemove([idStr])], merge: true)
        } else {
            // Add
            try await ref.setData(["savedOffers": FieldValue.arrayUnion([idStr])], merge: true)
        }

        // Read back and return as Set<UUID>
        let newSnap = try await ref.getDocument()
        let finalArr = (newSnap.data()?["savedOffers"] as? [String]) ?? []
        return Set(finalArr.compactMap(UUID.init(uuidString:)))
    }
}
