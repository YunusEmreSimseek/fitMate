//
//  UserSessionManager.swift
//  fitMate
//
//  Created by Emre Simsek on 13.04.2025.
//

import Foundation
import Observation

@Observable
final class UserSessionManager {
    private(set) var currentUser: UserModel?
    private let userService: IUserService

    init(userService: IUserService = AppContainer.shared.userService) {
        self.userService = userService
    }

    var isLoggedIn: Bool {
        currentUser != nil
    }

    func clearSession() {
        currentUser = nil
        print("User session cleared.")
    }

    func updateSession(_ user: UserModel) {
        currentUser = user
        print("User session updated: \(user)")
    }

    func updateUser(_ user: UserModel) async {
        currentUser = user
        guard let user = currentUser else { return }
        try? await userService.updateUser(user: user)
    }
}
