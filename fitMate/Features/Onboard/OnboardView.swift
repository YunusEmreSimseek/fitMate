//
//  OnboardView.swift
//  fitMate
//
//  Created by Emre Simsek on 3.11.2024.
//

import SwiftUI

struct OnboardView: View {
    @State private var viewModel: OnboardViewModel

    init(user: UserModel) {
        _viewModel = State(initialValue: OnboardViewModel(currentUser: user))
    }

    var body: some View {
        VStack {
            DividerView()

            TabView(selection: $viewModel.progress) {
                GenderView().tag(0)
                PhysicalView().tag(1)
                GoalView().tag(2)
            }

            RoundedRectangelButton(title: LocaleKeys.Onboard.bottomButton.localized) {
                viewModel.inclineProgress()
            }
        }
        .allPadding()
        .background(.cBackground)
        .environment(viewModel)
        .modifier(CenterLoadingViewModifier(isLoading: viewModel.isLoading))
    }
}

#Preview {
    OnboardView(user: UserModel(
        id: "12321312", email: "test", password: "test", name: "Test Name"
    ))
}

private struct DividerView: View {
    @Environment(OnboardViewModel.self) private var viewModel

    var body: some View {
        HStack {
            ForEach(0 ... viewModel.totalParts, id: \.self) { index in
                Rectangle()
                    .fill((index - 1) < viewModel.progress ? .cBlue : .gray)
                    .frame(height: 4)
            }
        }
    }
}
