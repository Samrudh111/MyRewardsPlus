//  HomeViewModel.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 12/19/2024.
//
import Foundation
import Observation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var offers: [Offer] = []
    @Published var isLoading = false
    private let offersService: OffersServiceType

    init(offersService: OffersServiceType = OffersService()) {
        self.offersService = offersService
    }

    func load() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        do { offers = try await offersService.fetchOffers() } catch { offers = [] }
    }
}
