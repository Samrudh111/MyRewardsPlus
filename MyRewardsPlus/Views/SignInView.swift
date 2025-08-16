//  SignInView.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 12/15/2024.
//
import SwiftUI

struct SignInView: View {
    @EnvironmentObject private var appState: AppState
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var errorMsg: String?

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Road Rewards").font(.largeTitle).bold()
                TextField("Email", text: $email).textInputAutocapitalization(.never)
                    .textContentType(.emailAddress).autocorrectionDisabled()
                    .padding().background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                SecureField("Password", text: $password)
                    .padding().background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))

                if let e = errorMsg { Text(e).foregroundStyle(.red) }

                Button {
                    Task { await signIn() }
                } label: { Text(isLoading ? "Signing in..." : "Sign In").frame(maxWidth: .infinity) }
                .rrBorderedProminent().disabled(isLoading)

                Button {
                    Task { await signUp() }
                } label: { Text("Create Account").frame(maxWidth: .infinity) }
                .rrBordered()

                Spacer()
            }
            .padding()
            .navigationTitle("Welcome")
        }
    }

    private func signIn() async {
        await authCall { try await appState.auth.signIn(email: email, password: password) }
    }
    private func signUp() async {
        await authCall { try await appState.auth.signUp(email: email, password: password) }
    }
    private func authCall(_ body: () async throws -> Void) async {
        errorMsg = nil; isLoading = true
        do { try await body() } catch { errorMsg = error.localizedDescription }
        isLoading = false
    }
}
