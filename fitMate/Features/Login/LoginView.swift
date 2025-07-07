//
//  LoginView.swift
//  fitMate
//
//  Created by Emre Simsek on 31.10.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var viewModel: LoginViewModel = .init()

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

private struct TopTitlesColumn: View {
    var body: some View {
        VStack {
            AppNameText()
            Text(LocaleKeys.Login.title.localized)
                .font(.title3)
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
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                    EmailField(text: $viewModel.emailValue)
                }
                VStack(alignment: .leading, spacing: .low3) {
                    Text(LocaleKeys.Login.password.localized)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                    PasswordField(text: $viewModel.passwordValue)
                }
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage.localized)
                        .font(.subheadline)
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

#Preview {
    LoginView()
        .environment(LoginViewModel())
}
