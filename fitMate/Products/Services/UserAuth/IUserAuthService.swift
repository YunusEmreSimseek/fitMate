//
//  IUserAuthService.swift
//  fitMate
//
//  Created by Emre Simsek on 12.04.2025.
//

import FirebaseAuth

/// Authentication service protocol
protocol IUserAuthService {
    /// Method for signing up with email and password
    func signUp(email: String, password: String) async throws -> AuthDataResult

    /// Method for signing in with email and password
    func signIn(email: String, password: String) async throws -> AuthDataResult

    /// Method for signing out
    func signOut() -> Bool

    /// Method for checking if user is authenticated
    func checkAuthUser() -> User?

    /// Method for checking current user
//    func currentUser() -> User?
}

extension IUserAuthService {
    var db: Auth {
        return Auth.auth()
    }
}
