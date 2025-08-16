//  OffersService.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 12/15/2024.
//
import Foundation

protocol OffersServiceType { func fetchOffers() async throws -> [Offer] }

struct OffersService: OffersServiceType {
    private let fs: FirestoreServiceType = FirestoreService()
    func fetchOffers() async throws -> [Offer] {
        try await fs.fetchOffers()
    }
}
