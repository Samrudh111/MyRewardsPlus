//  LocationsView.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 12/15/2024.
//
import SwiftUI
import MapKit

struct LocationsView: View {
    @StateObject private var vm = LocationsViewModel()
    @StateObject private var loc = LocationManager()

    var body: some View {
        NavigationStack {
            Map(coordinateRegion: $vm.region, annotationItems: vm.stations) { station in
                MapAnnotation(coordinate: station.coordinate) {
                    StationPin(station: station)
                        .onTapGesture { /* open station details if needed */ }
                }
            }
            .overlay(alignment: .topTrailing) {
                VStack(spacing: 8) {
                    Button { zoomToUser() } label: {
                        Image(systemName: "location.fill").padding(10)
                    }.background(.white, in: Circle())
                     .overlay(Circle().stroke(AppTheme.cardStroke))
                     .foregroundColor(AppTheme.red)

                    Button { Task { await vm.search(center: vm.region.center) } } label: {
                        Image(systemName: "magnifyingglass").padding(10)
                    }.background(.white, in: Circle())
                     .overlay(Circle().stroke(AppTheme.cardStroke))
                     .foregroundColor(AppTheme.red)
                }
                .padding()
            }
            .navigationTitle("Find Locations")
            .task {
                loc.request()
                await vm.search(center: vm.region.center)
            }
            .onChange(of: loc.location) { _, new in
                guard let c = new else { return }
                withAnimation { vm.region.center = c }
            }
            .background(AppTheme.grayBG.ignoresSafeArea())
        }
    }

    private func zoomToUser() {
        if let c = loc.location {
            withAnimation {
                vm.region = MKCoordinateRegion(center: c,
                                               span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
            }
        }
    }
}
