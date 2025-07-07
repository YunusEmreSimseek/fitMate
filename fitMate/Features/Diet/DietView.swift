//
//  DietView.swift
//  fitMate
//
//  Created by Emre Simsek on 30.04.2025.
//

import SwiftUI

struct DietView: View {
    @Environment(DietViewModel.self) private var viewModel
    var body: some View {
        @Bindable var viewModel = viewModel
        Group {
            if viewModel.isLoading {
                ProgressView(LocaleKeys.General.loading.localized)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if viewModel.userDietManager.dietPlan != nil {
                ActiveDietDashboardView()
            } else {
                EmptyDietStateView()
            }
        }
        .sheet(item: $viewModel.activeSheet) { _ in MenuSheet() }
    }
}

private struct EmptyDietStateView: View {
    @Environment(DietViewModel.self) private var viewModel

    var body: some View {
        VStack(spacing: .medium3) {
            Image(systemName: "leaf.circle")
                .resizable()
                .scaledToFit()
                .frame(height: .dynamicHeight(height: 0.1))
                .foregroundStyle(.cBlue)

            Text(LocaleKeys.Diet.EmptyState.title.localized)
                .multilineTextAlignment(.center)

            Button(LocaleKeys.Diet.EmptyState.buttonTitle.localized) {
                viewModel.activeSheet = .addDietPlan
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct DietToolbarMenu: View {
    @Environment(DietViewModel.self) private var viewModel
    var body: some View {
        Menu {
            Button(LocaleKeys.Diet.addDietTitle.localized) {
                viewModel.activeSheet = .addDietPlan
            }
            Button(LocaleKeys.Diet.addLogTitle.localized) {
                viewModel.activeSheet = .addDailyLog
            }
        } label: {
            Image(systemName: "plus")
                .imageScale(.large)
        }
    }
}

private struct MenuSheet: View {
    @Environment(DietViewModel.self) private var viewModel
    var body: some View {
        if let activeSheet = viewModel.activeSheet {
            switch activeSheet {
            case .addDietPlan:
                StartDietPlanSheet()
            case .addDailyLog:
                AddDailyDietLogSheet()
            }
        }
    }
}

#Preview {
    DietView()
        .environment(DietViewModel())
        .environment(ActiveDietDashboradViewModel())
        .environment(AppContainer.shared.userDietManager)
}
