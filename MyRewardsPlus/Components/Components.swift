//  PointsCard.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 12/15/2024.
//
import SwiftUI

struct PointsCard: View {
    var points: Int
    var tier: String
    var progress: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("\(points)")
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                Spacer()
                Text(tier)
                    .padding(.horizontal, 12).padding(.vertical, 6)
                    .background(.ultraThinMaterial, in: Capsule())
            }
            Text("Reward Points").foregroundStyle(.secondary)
            ProgressView(value: progress)
                .tint(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding(16)
        .background(
            LinearGradient(stops: [
                .init(color: Color.blue.opacity(0.15), location: 0),
                .init(color: Color.cyan.opacity(0.15), location: 1)
            ], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(.quaternary))
    }
}

struct ExpiringPointsBanner: View {
    var expiring: Int
    var body: some View {
        HStack {
            Image(systemName: "hourglass.circle.fill").font(.title2)
            VStack(alignment: .leading) {
                Text("\(expiring) pts expiring soon").bold()
                Text("Redeem them before month end.").font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer()
            Button("Redeem") { }
                .buttonStyle(.borderedProminent)
        }
        .padding(14)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}

struct OfferRow: View {
    var offer: Offer
    var isSaved: Bool
    var onToggleSave: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "gift.fill").font(.title2)
            VStack(alignment: .leading, spacing: 4) {
                Text(offer.title).bold()
                Text(offer.detail).foregroundStyle(.secondary)
                Text("+\(offer.pointsBonus) pts • Expires \(offer.expiresOn, style: .date)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Button(isSaved ? "Saved" : "Save") { onToggleSave() }
                .rrBordered()
        }
        .padding(12)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14))
    }
}

struct StationPin: View {
    var station: Station
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: "mappin.circle.fill").font(.title)
            Text(station.name).font(.caption2).lineLimit(1)
        }
        .padding(6)
        .background(.thinMaterial, in: Capsule())
    }
}

struct Tag: View {
    var text: String
    init(_ t: String) { text = t }
    var body: some View {
        Text(text)
            .font(.caption)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(.ultraThinMaterial, in: Capsule())
    }
}

struct AvatarCircle: View {
    var initials: String
    var body: some View {
        Circle()
            .fill(.blue.opacity(0.15))
            .frame(width: 44, height: 44)
            .overlay(Text(initials).bold())
    }
}

struct SectionHeader: View {
    var title: String
    init(_ t: String) { title = t }
    var body: some View { HStack { Text(title).font(.title3).bold(); Spacer() } }
}

struct EmptyState: View {
    var text: String
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "tray").font(.largeTitle)
            Text(text).foregroundStyle(.secondary)
        }.padding()
    }
}

extension View {
    /// iOS 15+: .buttonStyle(.bordered). Older iOS: fall back to a plain style.
    @ViewBuilder func rrBordered() -> some View {
        if #available(iOS 15.0, *) {
            self.buttonStyle(.bordered)
        } else {
            self.buttonStyle(PlainButtonStyle())
        }
    }

    /// iOS 15+: .buttonStyle(.borderedProminent). Older iOS: fall back to a plain style.
    @ViewBuilder func rrBorderedProminent() -> some View {
        if #available(iOS 15.0, *) {
            self.buttonStyle(.borderedProminent)
        } else {
            self.buttonStyle(PlainButtonStyle())
        }
    }
}
