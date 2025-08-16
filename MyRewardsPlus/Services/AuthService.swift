//  AuthService.swift
//  MyRewardsPlus
//
//  Created by Samrudh S on 01/10/2025.
//

import Foundation
import FirebaseAuth

protocol AuthServiceType {
    var userId: String? { get }
    func signIn(email: String, password: String) async throws
    func signUp(email: String, password: String) async throws
    func signOut() throws
    func listen(_ onChange: @escaping (String?) -> Void)
}

final class AuthService: AuthServiceType {
    private var handle: AuthStateDidChangeListenerHandle?
    var userId: String? { Auth.auth().currentUser?.uid }

    func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }

    func signUp(email: String, password: String) async throws {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }

    func signOut() throws { try Auth.auth().signOut() }

    func listen(_ onChange: @escaping (String?) -> Void) {
        handle = Auth.auth().addStateDidChangeListener { _, user in
            onChange(user?.uid)
        }
    }

    deinit { if let h = handle { Auth.auth().removeStateDidChangeListener(h) } }
}
