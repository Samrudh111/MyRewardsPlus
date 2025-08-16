//  LocationsViewModel.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 02/12/2025.
//
import Foundation
import MapKit

@MainActor
final class LocationsViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 36.1627, longitude: -86.7816),
        span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)
    )
    @Published var stations: [Station] = []
    @Published var isLoading = false

    private let service: StationServiceType
    init(service: StationServiceType = StationService()) { self.service = service }

    func search(center: CLLocationCoordinate2D) async {
        isLoading = true
        defer { isLoading = false }
        do {
            stations = try await service.nearbyStations(center: center, radiusKm: 50)
        } catch { stations = [] }
    }
}
