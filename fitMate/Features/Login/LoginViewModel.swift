//
//  LoginViewModel.swift
//  fitMate
//
//  Created by Emre Simsek on 3.11.2024.
//

import Alamofire
import Foundation

@Observable
final class LoginViewModel {
    var emailValue: String = ""
    var passwordValue: String = ""
    var isLoading: Bool = false
    var errorMessage: String?

    private var userSessionManager: UserSessionManager
    private var navigationManager: NavigationManager
    private var userService: IUserService
    private var userAuthService: IUserAuthService

    init(userSessionManager: UserSessionManager,
         navigationManager: NavigationManager,
         userService: IUserService,
         userAuthService: IUserAuthService)
    {
        self.userSessionManager = userSessionManager
        self.navigationManager = navigationManager
        self.userService = userService
        self.userAuthService = userAuthService
    }

    func navigateToSignUpView() {
        navigationManager.navigate(to_: .signUp)
    }

    func login() async {
        isLoading = true
        defer { isLoading = false }
        do {
            try validateLoginForm()
            let result = try await userAuthService.signIn(
                email: emailValue, password: passwordValue)
            let uid = result.user.uid
            let user = try await userService.fetchUser(by: uid)
            userSessionManager.updateSession(user)
            navigationManager.navigate(to_: .tabRoot)
        } catch let error as UserAuthServiceError {
            errorMessage = error.userFriendlyMessage
        } catch {
            errorMessage = LocaleKeys.Error.unknownError
        }
    }

    func validateLoginForm() throws {
        guard emailValue.isNotEmpty() else {
            throw UserAuthServiceError.emptyEmail
        }

        guard passwordValue.isNotEmpty() else {
            throw UserAuthServiceError.emptyPassword
        }

        guard emailValue.isValidEmail() else {
            throw UserAuthServiceError.invalidEmail
        }

        guard passwordValue.isValidPassword() else {
            throw UserAuthServiceError.weakPassword
        }
    }
}
