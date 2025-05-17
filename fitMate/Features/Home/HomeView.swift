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

    var body: some View {
        ScrollView {
            VStack(spacing: .normal) {
                AppNameText()
                MotivationCardView(
                    message: viewModel.motivationMessages[0],
                    image: .motivation2
                )
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: .normal) {
                    ForEach(viewModel.healthDataItems) { item in
                        InformationCardView(
                            title: item.title,
                            text: "\(item.value) \(item.unit)"
                        )
                    }
                }
                VStack(alignment: .leading, spacing: .low2) {
                    Text("Step Progress")
                        .font(.headline)

                    ProgressView(
                        value: min(healthKitManager.stepCount / goalManager.stepGoal, 1.0)
                    )
                    .progressViewStyle(.linear)
                    .tint(.cBlue)

                    Text("\(Int(healthKitManager.stepCount))/\(Int(goalManager.stepGoal)) steps")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .vPadding(.normal)
//                HStack {
//                    InformationCardView(title: "Steps Today", text: healthKitManager.stepCount.description)
//                    InformationCardView(title: "Calories Burned", text: "450")
//                }
                InformationCardView(title: "Workout Duration", text: "1hr 15min")
                AskAIView()
                HeartRateDataView()
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

#Preview {
    NavigationStack {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
        }
    }
}

private struct InformationCardView: View {
    let title: String
    let text: String
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: .normal)
                .fill(.cGray)
                .frame(height: .dynamicHeight(height: 0.125))
//                .foregroundStyle(.cGray)

//                .shadow(color: .primary.opacity(0.2), radius: 2, x: 0, y: 0)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 4)

            VStack(alignment: .leading, spacing: .low2) {
                Text(title)
                    .font(.subheadline)
                    .bold()
                Text(text)
                    .font(.title3)
                    .fontWeight(.heavy)
            }
            .allPadding()
        }
    }
}

private struct ToolbarUserView: View {
    @Environment(HomeViewModel.self) private var viewModel
    @Environment(UserSessionManager.self) private var userSessionManager
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "person.circle.fill")
                .font(.title)
            VStack(alignment: .leading) {
                Text(viewModel.greetingMessage().localized + ",")
                    .font(.headline)
                    .bold()
                Text(userSessionManager.currentUser?.name ?? "Kullanıcı Adı")
                    .foregroundColor(.cBlue)
                    .font(.subheadline)
                    .bold()
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

private struct MotivationCardView: View {
    let message: String
    let image: ImageResource
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                .overlay(
                    LinearGradient(
                        colors: [.black.opacity(0.1), .black.opacity(0.6)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .clipShape(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                )
                .shadow(radius: 5)

            Text(message)
                .font(.headline)
                .foregroundColor(.white)
                .allPadding()
        }
    }
}

private struct AskAIView: View {
//    @Environment(HomeTabViewModel.self) private var viewModel
    @Environment(NavigationManager.self) private var navigationManager
    var body: some View {
        HStack {
            Image(systemName: "brain.head.profile")
                .font(.title)
                .foregroundColor(.cBlue)
            VStack(alignment: .leading) {
                Text("Ask your AI Coach")
                    .font(.headline)
                    .bold()
                Text("Need workout tips? Nutrition advice?")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
        .vPadding(.normal)
//        .hPadding(.low2)
        .onTapGesture {
            navigationManager.changeSelectedTab(tab: .chat)
        }
    }
}
