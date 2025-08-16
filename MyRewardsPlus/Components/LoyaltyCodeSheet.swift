//  LoyaltyCodeSheet.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 12/15/2024.
//
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct LoyaltyCodeSheet: View {
    var code: String
    @Environment(\.dismiss) private var dismiss
    private let context = CIContext()
    private let qrFilter = CIFilter.qrCodeGenerator()
    private let barcodeFilter = CIFilter.code128BarcodeGenerator()

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Scan at Register or Pump").font(.headline)
                if let qr = makeQRCode(from: code) {
                    Image(uiImage: qr)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 220)
                        .padding()
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                }
                if let bar = makeBarcode(from: code) {
                    Image(uiImage: bar)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                        .padding(.horizontal)
                }
                Text(code).font(.footnote).foregroundStyle(.secondary)
                Spacer()
            }
            .padding()
            .navigationTitle("Loyalty Code")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) { Button("Done") { dismiss() } }
            }
        }
    }

    private func makeQRCode(from string: String) -> UIImage? {
        let data = Data(string.utf8)
        qrFilter.setValue(data, forKey: "inputMessage")
        qrFilter.correctionLevel = "M"
        guard let output = qrFilter.outputImage else { return nil }
        let scaled = output.transformed(by: CGAffineTransform(scaleX: 8, y: 8))
        if let cgimg = context.createCGImage(scaled, from: scaled.extent) {
            return UIImage(cgImage: cgimg)
        }
        return nil
    }

    private func makeBarcode(from string: String) -> UIImage? {
        let data = Data(string.utf8)
        barcodeFilter.setValue(data, forKey: "inputMessage")
        barcodeFilter.setValue(0, forKey: "inputQuietSpace")
        guard let output = barcodeFilter.outputImage else { return nil }
        let scaled = output.transformed(by: CGAffineTransform(scaleX: 3, y: 3))
        if let cgimg = context.createCGImage(scaled, from: scaled.extent) {
            return UIImage(cgImage: cgimg)
        }
        return nil
    }
}
