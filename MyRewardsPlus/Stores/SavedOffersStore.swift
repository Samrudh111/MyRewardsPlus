//  SavedOffersStore.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 12/15/2024.
//
import SwiftUI

final class SavedOffersStore: ObservableObject {
    @AppStorage("savedOffers") private var savedData: Data = Data()
    @Published var ids: Set<UUID> = []

    init() { load() }

    func load() {
        if let decoded = try? JSONDecoder().decode([UUID].self, from: savedData) {
            ids = Set(decoded)
        } else { ids = [] }
    }

    func persist() {
        let array = Array(ids)
        savedData = (try? JSONEncoder().encode(array)) ?? Data()
    }

    func contains(_ id: UUID) -> Bool { ids.contains(id) }

    func toggle(_ id: UUID) {
        if ids.contains(id) { ids.remove(id) } else { ids.insert(id) }
        persist()
        objectWillChange.send()
    }

    var count: Int { ids.count }
}
