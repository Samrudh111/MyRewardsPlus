//  Models.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 01/13/2024.
//
import Foundation
import CoreLocation

struct RewardAccount: Identifiable, Codable {
    let id: UUID
    var memberName: String
    var points: Int
    var tier: Tier
    var expiringPoints: Int
    var nextTierPoints: Int
    var loyaltyNumber: String   // used for QR/Barcode

    enum Tier: String, Codable, CaseIterable { case Silver, Gold, Platinum }
}

struct Station: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let coordinate: CLLocationCoordinate2D
    let address: String
    let amenities: [Amenity]
    let dieselPrice: Double?
    let gasPrice: Double?

    enum Amenity: String, Codable, CaseIterable { case Showers, Laundry, Parking, EV, ATM, Restaurant }
}

struct Offer: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let detail: String
    let pointsBonus: Int
    let expiresOn: Date
}
