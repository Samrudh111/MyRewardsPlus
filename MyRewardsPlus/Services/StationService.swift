//  StationService.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 12/15/2024.
//
import Foundation
import CoreLocation

protocol StationServiceType {
    func nearbyStations(center: CLLocationCoordinate2D, radiusKm: Double) async throws -> [Station]
}

struct StationService: StationServiceType {
    func nearbyStations(center: CLLocationCoordinate2D, radiusKm: Double) async throws -> [Station] {
        // In a real app, call your backend. Here we filter sample stations by rough radius.
        try await Task.sleep(nanoseconds: 150_000_000)
        let all = SampleData.stations
        let R = radiusKm * 1000
        return all.filter { st in
            let d = CLLocation(latitude: st.coordinate.latitude, longitude: st.coordinate.longitude)
                .distance(from: CLLocation(latitude: center.latitude, longitude: center.longitude))
            return d <= R
        }
    }
}
