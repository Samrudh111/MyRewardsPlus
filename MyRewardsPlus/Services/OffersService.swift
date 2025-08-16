//  OffersService.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 02/18/2024.
//

import Foundation

protocol OffersServiceType {
    func fetchOffers() async throws -> [Offer]
}

struct OffersService: OffersServiceType {

    // Set this to true if you want to force local-only during demos
    private let ALWAYS_USE_LOCAL_OFFERS = false

    func fetchOffers() async throws -> [Offer] {
        if ALWAYS_USE_LOCAL_OFFERS {
            return SampleData.offers
        }

        do {
            let remote = try await FirestoreService().fetchOffers()
            if !remote.isEmpty {
                return remote
            }
        } catch {
            // Ignore and fall back
        }
        return SampleData.offers
    }
}
