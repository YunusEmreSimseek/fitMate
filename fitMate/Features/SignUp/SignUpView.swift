//
//  SignUpView.swift
//  fitMate
//
//  Created by Emre Simsek on 2.11.2024.
//

import SwiftUI

struct SignUpView: View {
    @State private var viewModel: SignUpViewModel

    init(
        userSessionManager: UserSessionManager = AppContainer.shared.userSessionManager,
        navigationManager: NavigationManager = AppContainer.shared.navigationManager,
        userService: IUserService = AppContainer.shared.userService,
        userAuthService: IUserAuthService = AppContainer.shared.userAuthService
    ) {
        _viewModel = State(initialValue: SignUpViewModel(
            userSessionManager: userSessionManager,
            navigationManager: navigationManager,
            userService: userService,
            userAuthService: userAuthService))
    }

    var body: some View {
        ZStack {
            DynamicBgImage()

            ScrollView {
                VStack(spacing: .high3) {
                    TopTitlesColumn()

                    CenterFieldsAndButtonColumn()

                    BottomTextsRow()
                }
                .ignoresSafeArea(.keyboard)
                .allPadding()
            }
        }
        .environment(viewModel)
        .modifier(TopBarLoadingViewModifier(isLoading: viewModel.isLoading))
    }
}

private struct TopTitlesColumn: View {
    var body: some View {
        VStack {
            AppNameText()
            Text(LocaleKeys.SignUp.title.localized)
                .font(.title2)
                .fontWeight(.bold)
        }
    }
}

private struct CenterFieldsAndButtonColumn: View {
    @Environment(SignUpViewModel.self) private var viewModel
    var body: some View {
        @Bindable var viewModel = viewModel
        VStack(alignment: .leading,spacing: .normal) {
            VStack(alignment: .leading, spacing: .low) {
                VStack(alignment: .leading, spacing: .low3) {
                    Text(LocaleKeys.SignUp.name.localized)
                        .font(.normal)
                        .fontWeight(.medium)
                    NameField(text: $viewModel.nameValue)
                }
                VStack(alignment: .leading, spacing: .low3) {
                    Text(LocaleKeys.SignUp.email.localized)
                        .font(.normal)
                        .fontWeight(.medium)
                    EmailField(text: $viewModel.emailValue)
                }
                VStack(alignment: .leading, spacing: .low3) {
                    Text(LocaleKeys.SignUp.password.localized)
                        .font(.normal)
                        .fontWeight(.medium)
                    PasswordField(text: $viewModel.passwordValue)
                }
                VStack(alignment: .leading, spacing: .low3) {
                    Text(LocaleKeys.SignUp.repeatPassword.localized)
                        .font(.normal)
                        .fontWeight(.medium)
                    PasswordField(text: $viewModel.repeatPasswordValue)
                }
            }
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage.localized)
                    .font(.normal)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.leading)
            }
            RoundedRectangelButton(title: LocaleKeys.SignUp.button.localized) {
                Task {
                    await viewModel.signUp()
                }
            }
        }
    }
}

private struct BottomTextsRow: View {
    @Environment(SignUpViewModel.self) private var viewModel

    var body: some View {
        HStack {
            Text(LocaleKeys.SignUp.bottomText.localized)
            Button(LocaleKeys.SignUp.loginButton.localized) {
                viewModel.navigateToLoginView()
            }
            .foregroundStyle(.cBlue)
            .bold()
        }
    }
}

#Preview {
    SignUpView()
}
