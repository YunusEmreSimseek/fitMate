//
//  SignUpViewModel.swift
//  fitMate
//
//  Created by Emre Simsek on 2.11.2024.
//

import Foundation

@Observable
final class SignUpViewModel {
    var nameValue: String = ""
    var emailValue: String = ""
    var passwordValue: String = ""
    var errorMessage: String?
    var isLoading: Bool = false

    private var userSessionManager: UserSessionManager
    private var navigationManager: NavigationManager
    private var userAuthService: IUserAuthService
    private var userService: IUserService

    init(userSessionManager: UserSessionManager = AppContainer.shared.userSessionManager,
         navigationManager: NavigationManager = AppContainer.shared.navigationManager,
         userService: IUserService = AppContainer.shared.userService,
         userAuthService: IUserAuthService = AppContainer.shared.userAuthService)
    {
        self.userSessionManager = userSessionManager
        self.navigationManager = navigationManager
        self.userService = userService
        self.userAuthService = userAuthService
    }

    func navigateToLoginView() {
        navigationManager.navigate(to_: .login)
    }

//    func navigateToOnboardView(user: UserModel) {
//        navigationManager.navigate(to_: .onboard(user: user))
//    }

    func navigateToHomeView() {
        navigationManager.navigate(to_: .tabRoot)
    }

    func signUp() async {
        isLoading = true
        defer { isLoading = false }
        do {
            try validateSignUpForm()
            let result = try await userAuthService.signUp(email: emailValue, password: passwordValue)
            let user = UserModel(
                id: result.user.uid,
                email: emailValue,
                password: passwordValue,
                name: nameValue,
                createdAt: Date.now
            )
            try await userService.createUser(user: user)
            userSessionManager.updateSession(user)
//            navigateToOnboardView(user: user)
            navigateToHomeView()
        } catch let error as UserAuthServiceError {
            errorMessage = error.userFriendlyMessage
        } catch {
            errorMessage = LocaleKeys.Error.unknownError
        }
    }

    func validateSignUpForm() throws {
        guard nameValue.isNotEmpty() else {
            throw UserAuthServiceError.emptyName
        }

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
