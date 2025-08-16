//  SampleData.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 12/15/2024.
//
import Foundation
import CoreLocation

enum SampleData {
    static let account = RewardAccount(
        id: UUID(),
        memberName: "Alex Morgan",
        points: 3240,
        tier: .Gold,
        expiringPoints: 240,
        nextTierPoints: 5000,
        loyaltyNumber: "7041 9923 5581"
    )

    static let stations: [Station] = [
        Station(id: UUID(), name: "RoadHub Nashville",
                coordinate: .init(latitude: 36.1627, longitude: -86.7816),
                address: "123 Broadway, Nashville, TN",
                amenities: [.Showers, .Parking, .Restaurant],
                dieselPrice: 3.79, gasPrice: 3.19),
        Station(id: UUID(), name: "RoadHub Knoxville",
                coordinate: .init(latitude: 35.9606, longitude: -83.9207),
                address: "45 Cumberland Ave, Knoxville, TN",
                amenities: [.EV, .ATM, .Restaurant],
                dieselPrice: 3.69, gasPrice: 3.09),
        Station(id: UUID(), name: "RoadHub Louisville",
                coordinate: .init(latitude: 38.2527, longitude: -85.7585),
                address: "200 Main St, Louisville, KY",
                amenities: [.Showers, .Laundry, .Parking],
                dieselPrice: 3.89, gasPrice: 3.25),
        Station(id: UUID(), name: "RoadHub St. Louis",
                coordinate: .init(latitude: 38.6270, longitude: -90.1994),
                address: "10 Market St, St. Louis, MO",
                amenities: [.Parking, .EV, .ATM],
                dieselPrice: 3.59, gasPrice: 3.05)
    ]

    static let offers: [Offer] = [
        Offer(id: UUID(), title: "10¢/gal off Next Fill",
              detail: "Save instantly at the pump on your next transaction.",
              pointsBonus: 0,
              expiresOn: Calendar.current.date(byAdding: .day, value: 7, to: .now)!),
        Offer(id: UUID(), title: "+300 pts Coffee Bundle",
              detail: "Buy 3 coffees this week and earn a 300 pt bonus.",
              pointsBonus: 300,
              expiresOn: Calendar.current.date(byAdding: .day, value: 5, to: .now)!),
        Offer(id: UUID(), title: "Snack Combo Deal",
              detail: "Chips + Drink combo with extra 150 pts.",
              pointsBonus: 150,
              expiresOn: Calendar.current.date(byAdding: .day, value: 10, to: .now)!)
    ]
}

extension RewardAccount { static let sample = SampleData.account }
