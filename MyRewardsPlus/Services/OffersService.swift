//  OffersService.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 02/18/2025.
//

import Foundation

protocol OffersServiceType {
    func fetchOffers() async throws -> [Offer]
}

struct OffersService: OffersServiceType {
    func fetchOffers() async throws -> [Offer] {
        return SampleData.offers
    }
}
