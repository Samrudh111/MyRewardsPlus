//  StationSheet.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 12/15/2024.
//
import SwiftUI

struct StationSheet: View {
    var station: Station
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack { Text(station.name).font(.title2).bold(); Spacer() }
            Text(station.address).foregroundStyle(.secondary)
            HStack {
                if let gas = station.gasPrice { Tag(text: "Gas $\(String(format: "%.2f", gas))") }
                if let diesel = station.dieselPrice { Tag(text: "Diesel $\(String(format: "%.2f", diesel))") }
            }
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80), spacing: 8)], spacing: 8) {
                ForEach(station.amenities, id: \.self) { Tag(text: $0.rawValue) }
            }
            Button {
                // Navigate or start fuel pay flow
            } label: {
                Label("Navigate", systemImage: "arrow.triangle.turn.up.right.diamond.fill")
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
        .padding()
        .presentationDetents([.medium, .large])
    }
}
