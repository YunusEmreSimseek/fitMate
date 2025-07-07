//
//  HomeView.swift
//  fitMate
//
//  Created by Emre Simsek on 6.11.2024.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel: HomeViewModel = .init(healthKitManager: AppContainer.shared.healthKitManager)
    @Environment(HealthKitManager.self) private var healthKitManager
    @Environment(GoalManager.self) private var goalManager
    @Environment(\.scenePhase) private var scenePhase
    @Environment(UserWorkoutManager.self) private var userWorkoutManager
    @Environment(UserDietManager.self) private var userDietManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .normal) {
                AppNameText()
                MotivationSliderView()
                GeneralInformationView()
                StepProgressView()
                AskAIView()

                if userWorkoutManager.logs.count > 0 {
                    WorkoutSummaryView()
                }

                if userDietManager.dietPlan != nil {
                    AverageProgressCard()
                }
                Spacer()
            }
            .allPadding()
        }

        .modifier(ToolbarViewModifier(view: AnyView(ToolbarUserView()), placement: .topBarLeading))
        .modifier(ToolbarViewModifier(view: AnyView(ToolbarNotificationView()), placement: .topBarTrailing))
        .background(.cBackground)
        .environment(viewModel)
        .onAppear {
            Task { await healthKitManager.fetchAllData() }
        }
        .onChange(of: scenePhase) { _, newValue in
            if newValue == .background {
                Task {
                    await healthKitManager.fetchAllData()
                    await healthKitManager.saveTodayHealthData()
                }
            }
        }
    }
}

private struct MotivationSliderView: View {
    @State private var selectedIndex: Int = 0
    private let images: [ImageResource] = [.motivation, .motivation2]
    var body: some View {
        ZStack(alignment: .top) {
            switch selectedIndex {
            case 0:
                MotivationCardView(
                    message: LocaleKeys.Home.Motivation.first.localized,
                    image: .motivation
                )

            case 1:
                MotivationCardView(
                    message: LocaleKeys.Home.Motivation.second.localized,
                    image: .motivation2
                )

            default:
                MotivationCardView(
                    message: LocaleKeys.Home.Motivation.first.localized,
                    image: .motivation
                )
            }
            HStack(spacing: .zero) {
                ForEach(images.indices, id: \.self) { index in
                    Rectangle()
                        .fill(index == selectedIndex ? Color.cBlue : Color.cGray.opacity(0.5))
                        .frame(height: 4)
                        .onTapGesture {
                            withAnimation {
                                selectedIndex = index
                            }
                        }
                }
            }
        }
        .animation(.easeInOut, value: selectedIndex)
        .clipShape(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
        )
        .shadow(radius: 5)
    }
}

private struct GeneralInformationView: View {
    @Environment(HomeViewModel.self) private var viewModel
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: .normal) {
            ForEach(viewModel.healthDataItems) { item in
                InformationCardView(
                    title: item.title,
                    text: "\(item.value) \(item.unit)"
                )
            }
        }
    }
}

private struct ToolbarNotificationView: View {
    var body: some View {
        Button {
            print("Bildirim tıklandı")
        } label: {
            Image(systemName: "bell.badge")
                .font(.title3)
                .foregroundStyle(.cBlue)
        }
    }
}

private struct AskAIView: View {
    @Environment(NavigationManager.self) private var navigationManager
    var body: some View {
        HStack {
            Image(systemName: "brain.head.profile")
                .font(.title)
                .foregroundColor(.cBlue)
            VStack(alignment: .leading) {
                Text(LocaleKeys.Home.AskAI.title.localized)
                    .font(.headline)
                    .bold()
                Text(LocaleKeys.Home.AskAI.subTitle.localized)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
        .card(cornerRadius: .low, padding: .low)
        .onTapGesture {
            navigationManager.changeSelectedTab(tab: .chat)
        }
    }
}

private struct StepProgressView: View {
    @Environment(HealthKitManager.self) private var healthKitManager
    @Environment(UserSessionManager.self) private var userSessionManager
    var body: some View {
        VStack(alignment: .leading, spacing: .low2) {
            Text(LocaleKeys.Home.stepTitle.localized)
                .font(.headline).bold()

            ProgressView(
                value: min(healthKitManager.stepCount / Double(userSessionManager.currentUser?.stepGoal ?? 10000), 1.0)
            )
            .progressViewStyle(.linear)
            .tint(.cBlue)

            Text("\(Int(healthKitManager.stepCount))/\(Int(userSessionManager.currentUser?.stepGoal ?? 10000)) \(LocaleKeys.Measurement.steps.localized)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .card(cornerRadius: .low, padding: .low)
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environment(AppContainer.shared.healthKitManager)
            .environment(AppContainer.shared.goalManager)
            .environment(AppContainer.shared.navigationManager)
            .environment(AppContainer.shared.userSessionManager)
            .environment(AppContainer.shared.userWorkoutManager)
            .environment(AppContainer.shared.userDietManager)
    }
}
