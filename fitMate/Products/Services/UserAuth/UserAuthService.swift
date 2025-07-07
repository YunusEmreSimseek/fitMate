//
//  UserAuthService.swift
//  fitMate
//
//  Created by Emre Simsek on 12.04.2025.
//

import FirebaseAuth

final class UserAuthService: IUserAuthService {
    private let logManager = AppContainer.shared.logManager
    func signUp(email: String, password: String) async throws -> AuthDataResult {
        logManager.debug("[UserAuthService] Sign up called with email: \(email)")
        return try await withCheckedThrowingContinuation { continuation in
            db.createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    let mappedError = self.mapFirebaseError(error)
                    self.logManager.error("[UserAuthService] Sign up failed: \(mappedError)")
                    continuation.resume(throwing: mappedError)
                } else if let result = result {
                    self.logManager.info("[UserAuthService] Sign up successful for user: \(result.user.uid)")
                    continuation.resume(returning: result)
                } else {
                    self.logManager.error("[UserAuthService] Sign up failed: Unknown error")
                    continuation.resume(throwing: UserAuthServiceError.unknownError)
                }
            }
        }
    }

    func signIn(email: String, password: String) async throws -> AuthDataResult {
        logManager.debug("[UserAuthService] Sign in called with email: \(email)")
        return try await withCheckedThrowingContinuation { continuation in
            db.signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    let mappedError = self.mapFirebaseError(error)
                    self.logManager.error("[UserAuthService] Sign in failed: \(mappedError)")
                    continuation.resume(throwing: mappedError)
                } else if let result = result {
                    self.logManager.info("[UserAuthService] Sign in successful for user: \(result.user.uid)")
                    continuation.resume(returning: result)
                } else {
                    self.logManager.error("[UserAuthService] Sign in failed: Unknown error")
                    continuation.resume(throwing: UserAuthServiceError.wrongPassword)
                }
            }
        }
    }

    func signOut() -> Bool {
        logManager.debug("[UserAuthService] Sign out called")
        do {
            try db.signOut()
            logManager.info("User signed out successfully")
            return true
        } catch {
            logManager.error("Sign out failed: \(error.localizedDescription)")
            return false
        }
    }

    func checkAuthUser() -> User? {
        logManager.debug("[UserAuthService] Check authenticated user")
        if let user = db.currentUser {
            logManager.info("[UserAuthService] Authenticated user found: \(user.uid)")
            return user
        } else {
            logManager.warning("[UserAuthService] No authenticated user found")
            return nil
        }
    }
}

enum UserAuthServiceError: Error {
    case invalidEmail
    case emailAlreadyInUse
    case weakPassword
    case wrongPassword
    case userNotFound
    case unknownError
    case passwordsDoNotMatch
    case emptyName
    case emptyEmail
    case emptyPassword
}

extension UserAuthServiceError {
    var userFriendlyMessage: String {
        switch self {
        case .invalidEmail:
            return LocaleKeys.Error.invalidEmail
        case .emailAlreadyInUse:
            return LocaleKeys.Error.emailAlreadyInUse
        case .weakPassword:
            return LocaleKeys.Error.weakPassword
        case .wrongPassword:
            return LocaleKeys.Error.wrongPassword
        case .userNotFound:
            return LocaleKeys.Error.userNotFound
        case .unknownError:
            return LocaleKeys.Error.unknownError
        case .passwordsDoNotMatch:
            return LocaleKeys.Error.passwordsDoNotMatch
        case .emptyName:
            return LocaleKeys.Error.emptyName
        case .emptyEmail:
            return LocaleKeys.Error.emptyEmail
        case .emptyPassword:
            return LocaleKeys.Error.emptyPassword
        }
    }
}

extension UserAuthService {
    private func mapFirebaseError(_ error: Error) -> UserAuthServiceError {
        let errorCode = (error as NSError).code

        switch errorCode {
        case AuthErrorCode.invalidEmail.rawValue:
            return .invalidEmail
        case AuthErrorCode.emailAlreadyInUse.rawValue:
            return .emailAlreadyInUse
        case AuthErrorCode.weakPassword.rawValue:
            return .weakPassword
        case AuthErrorCode.wrongPassword.rawValue:
            return .wrongPassword
        case AuthErrorCode.userNotFound.rawValue:
            return .userNotFound
        default:
            return .unknownError
        }
    }
}
