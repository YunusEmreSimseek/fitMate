//
//  UserService.swift
//  fitMate
//
//  Created by Emre Simsek on 13.04.2025.
//
import FirebaseFirestore

final class UserService: IUserService {
    private lazy var db = Firestore.firestore()
    private let usersCollection = FirebaseCollections.users.rawValue
    private let logManager = AppContainer.shared.logManager

    func createUser(user: UserModel) async throws {
        logManager.debug("[UserService] CreateUser called with user: \(user)")
        guard let uid = user.id else {
            logManager.error("[UserService] CreateUser failed: Invalid user ID")
            throw UserServiceError.invalidUserID
        }
        do {
            try db.collection(usersCollection).document(uid).setData(from: user)
            logManager.info("[UserService] User successfully created with ID: \(uid)")
        } catch {
            logManager.error("[UserService] CreateUser failed with error: \(error.localizedDescription)")
            throw UserServiceError.unknownError(error)
        }
    }

    func updateUser(user: UserModel) async throws {
        logManager.debug("[UserService] UpdateUser called with user: \(user)")
        guard let uid = user.id else {
            logManager.error("[UserService] UpdateUser failed: Invalid user ID")
            throw UserServiceError.invalidUserID
        }
        do {
            try db.collection(usersCollection).document(uid).setData(from: user, merge: true)
            logManager.info("[UserService] User successfully updated with ID: \(uid)")
        } catch {
            logManager.error("[UserService] UpdateUser failed with error: \(error.localizedDescription)")
            throw UserServiceError.unknownError(error)
        }
    }

    func fetchUser(by uid: String) async throws -> UserModel {
        logManager.debug("[UserService] FetchUser called with user ID: \(uid)")
        do {
            let snapshot = try await db.collection(usersCollection).document(uid).getDocument()
            guard snapshot.exists else {
                logManager.error("[UserService] FetchUser failed: Document does not exist")
                throw UserServiceError.userNotFound
            }
            guard let user = try? snapshot.data(as: UserModel.self) else {
                logManager.error("[UserService] FetchUser failed: User not found or parsing error")
                throw UserServiceError.parsingError
            }
            logManager.debug("[UserService] User successfully fetched with ID: \(uid)")
            return user
        } catch {
            logManager.error("[UserService] FetchUser failed with error: \(error.localizedDescription)")
            throw UserServiceError.unknownError(error)
        }
    }
}

enum UserServiceError: LocalizedError {
    case invalidUserID
    case userNotFound
    case parsingError
    case unknownError(Error)

    var errorDescription: String? {
        switch self {
        case .invalidUserID:
            return "Invalid user ID."
        case .userNotFound:
            return "The user could not be found."
        case .parsingError:
            return "Failed to parse user data."
        case let .unknownError(error):
            return "Unexpected error: \(error.localizedDescription)"
        }
    }
}
