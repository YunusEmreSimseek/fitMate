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
    private var userWorkoutManager: UserWorkoutManager
    private var userDietManager: UserDietManager

    init(userSessionManager: UserSessionManager = AppContainer.shared.userSessionManager,
         navigationManager: NavigationManager = AppContainer.shared.navigationManager,
         userService: IUserService = AppContainer.shared.userService,
         userAuthService: IUserAuthService = AppContainer.shared.userAuthService,
         userWorkoutManager: UserWorkoutManager = AppContainer.shared.userWorkoutManager,
         userDietManager: UserDietManager = AppContainer.shared.userDietManager)
    {
        self.userSessionManager = userSessionManager
        self.navigationManager = navigationManager
        self.userService = userService
        self.userAuthService = userAuthService
        self.userWorkoutManager = userWorkoutManager
        self.userDietManager = userDietManager
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
                email: emailValue, password: passwordValue
            )
            let uid = result.user.uid
            let user = try await userService.fetchUser(by: uid)
            userSessionManager.updateSession(user)
            await userWorkoutManager.loadManager()
            await userDietManager.loadManager()
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
    }
}
