//  LocationCoordinate.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 01/17/2025.
//
import Foundation
import CoreLocation

// Codable helpers
extension CLLocationCoordinate2D: Codable {
    public func encode(to encoder: Encoder) throws {
        var c = encoder.unkeyedContainer()
        try c.encode(longitude)
        try c.encode(latitude)
    }
    public init(from decoder: Decoder) throws {
        var c = try decoder.unkeyedContainer()
        let lon = try c.decode(CLLocationDegrees.self)
        let lat = try c.decode(CLLocationDegrees.self)
        self.init(latitude: lat, longitude: lon)
    }
}

// Equatable & Hashable so Station’s synthesized conformances work.
extension CLLocationCoordinate2D: Equatable, Hashable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(latitude)
        hasher.combine(longitude)
    }
}
