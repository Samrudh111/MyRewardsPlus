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
                    .background(AppTheme.yellow, in: Capsule())
                    .foregroundColor(AppTheme.ink)
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
        .background(AppTheme.heroGradient)
        .foregroundColor(.white)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(AppTheme.cardStroke))
    }
}

struct ExpiringPointsBanner: View {
    var expiring: Int
    var body: some View {
        HStack {
            Image(systemName: "hourglass.circle.fill")
                .foregroundColor(AppTheme.yellow)
            VStack(alignment: .leading) {
                Text("\(expiring) pts expiring soon").bold()
                Text("Redeem them before month end.").font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer()
            Button("Redeem") { }
                .buttonStyle(PrimaryButtonStyle())
        }
        .padding(14)
        .background(.white, in: RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(AppTheme.cardStroke))
    }
}

struct OfferRow: View {
    var offer: Offer
    var isSaved: Bool
    var onToggleSave: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            ZStack{
                Circle().fill(AppTheme.yellow)
                Image(systemName: "gift.fill").foregroundColor(AppTheme.ink)
            }
            .frame(width: 36, height: 36)
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
        .background(.white, in: RoundedRectangle(cornerRadius: 14))
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(AppTheme.cardStroke))
    }
}

struct StationPin: View {
    var station: Station
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundColor(AppTheme.red)
                .shadow(radius: 1, y: 1)
            Text(station.name).font(.caption2).lineLimit(1)
        }
        .padding(6)
        .background(.white, in: Capsule())
        .overlay(Capsule().stroke(AppTheme.cardStroke))
    }
}

struct Tag: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.caption)
            .padding(.vertical, 4).padding(.horizontal, 10)
            .foregroundColor(AppTheme.ink)
            .background(AppTheme.yellow.opacity(0.35), in: Capsule())
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
