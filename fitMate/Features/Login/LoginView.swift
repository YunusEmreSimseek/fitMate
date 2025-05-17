//
//  LoginView.swift
//  fitMate
//
//  Created by Emre Simsek on 31.10.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var viewModel: LoginViewModel

    init(userSessionManager: UserSessionManager = AppContainer.shared.userSessionManager,
         navigationManager: NavigationManager = AppContainer.shared.navigationManager,
         userService: IUserService = AppContainer.shared.userService,
         userAuthService: IUserAuthService = AppContainer.shared.userAuthService)
    {
        _viewModel = State(initialValue: LoginViewModel(
            userSessionManager: userSessionManager,
            navigationManager: navigationManager,
            userService: userService,
            userAuthService: userAuthService))
    }

    var body: some View {
        ZStack {
            DynamicBgImage()

            VStack(spacing: .high3) {
                TopTitlesColumn()

                CenterFieldsAndButtonColumn()

                BottomTextsRow()
            }
            .ignoresSafeArea(.keyboard)
            .allPadding()
        }
        .environment(viewModel)
        .modifier(TopBarLoadingViewModifier(isLoading: viewModel.isLoading))
    }
}

#Preview {
    LoginView()
}

private struct TopTitlesColumn: View {
    var body: some View {
        VStack {
            AppNameText()
            Text(LocaleKeys.Login.title.localized)
                .font(.title2)
                .fontWeight(.bold)
        }
    }
}

private struct CenterFieldsAndButtonColumn: View {
    @Environment(LoginViewModel.self) private var viewModel
    var body: some View {
        @Bindable var viewModel = viewModel
        VStack(alignment: .leading, spacing: .normal) {
            VStack(alignment: .leading, spacing: .low) {
                VStack(alignment: .leading, spacing: .low3) {
                    Text(LocaleKeys.Login.email.localized)
                        .font(.normal)
                        .fontWeight(.medium)
                    EmailField(text: $viewModel.emailValue)
                }
                VStack(alignment: .leading, spacing: .low3) {
                    Text(LocaleKeys.Login.password.localized)
                        .font(.normal)
                        .fontWeight(.medium)
                    PasswordField(text: $viewModel.passwordValue)
                }
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage.localized)
                        .font(.normal)
                        .foregroundColor(.red)
                }
            }

            RoundedRectangelButton(title: LocaleKeys.Login.button.localized) {
                Task { await viewModel.login() }
            }
        }
    }
}

private struct BottomTextsRow: View {
    @Environment(LoginViewModel.self) private var viewModel

    var body: some View {
        HStack {
            Text(LocaleKeys.Login.bottomText.localized)
            Button(LocaleKeys.Login.signUpButton.localized) {
                viewModel.navigateToSignUpView()
            }
            .foregroundStyle(.cBlue)
            .bold()
        }
    }
}
