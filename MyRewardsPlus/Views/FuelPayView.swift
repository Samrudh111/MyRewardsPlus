//  FuelPayView.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 02/15/2025.
//
import SwiftUI

struct FuelPayView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "fuelpump.fill").font(.system(size: 48))
            Text("Mobile Fuel Pay")
                .font(.title2).bold()
            Text("This is a placeholder for your secure, pump-activation flow. Integrate your payment tokenization provider here.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Button("Learn More") { }
                .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .navigationTitle("Fuel Pay")
    }
}
