//  SignInView.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 12/15/2024.
//

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    @EnvironmentObject private var appState: AppState
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var errorMsg: String?

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("SignIn").font(.largeTitle).bold()

                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))

                SecureField("Password", text: $password)
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))

                if let e = errorMsg {
                    Text(e).foregroundStyle(.red).font(.footnote)
                }

                Button {
                    Task { await signIn() }
                } label: {
                    Text(isLoading ? "Signing in…" : "Sign In")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(PrimaryButtonStyle())
                .rrBorderedProminent()
                .disabled(isLoading)

                Button {
                    Task { await signUp() }
                } label: {
                    Text("Create Account")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(SecondaryButtonStyle())
                .rrBordered()
                .disabled(isLoading)

                // Divider
                HStack {
                    Rectangle().frame(height: 1).opacity(0.2)
                    Text("or").foregroundStyle(.secondary)
                    Rectangle().frame(height: 1).opacity(0.2)
                }
                .padding(.vertical, 4)

                // Continue as Guest (Anonymous)
                Button {
                    Task { await signInAnonymously() }
                } label: {
                    Label("Continue as Guest", systemImage: "person.crop.circle.badge.questionmark")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(SecondaryButtonStyle())
                .rrBordered()

                Spacer()
            }
            .padding()
            .navigationTitle("My Rewards+")
        }
    }

    private func signIn() async {
        await callAuth { try await appState.auth.signIn(email: email, password: password) }
    }

    private func signUp() async {
        await callAuth { try await appState.auth.signUp(email: email, password: password) }
    }

    private func signInAnonymously() async {
        await callAuth { try await Auth.auth().signInAnonymously() }
    }

    private func callAuth(_ block: () async throws -> Void) async {
        errorMsg = nil
        isLoading = true
        defer { isLoading = false }
        do {
            try await block()
        } catch {
            let ns = error as NSError
            print("[Auth] code=\(ns.code) domain=\(ns.domain) info=\(ns.userInfo)")
            errorMsg = ns.localizedDescription
        }
    }
}
