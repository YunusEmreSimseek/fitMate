//
//  ProfileView.swift
//  fitMate
//
//  Created by Emre Simsek on 13.04.2025.
//

import SwiftUI

struct ProfileView: View {
    @State private var viewModel: ProfileViewModel = .init()
    var body: some View {
        ScrollView {
            VStack(spacing: .medium3) {
                HeaderView()
                ProfileDetailsView()
            }
        }
        .background(.cBackground)
        .navigationTitle(LocaleKeys.Profile.title.localized)
        .navigationBarTitleDisplayMode(.inline)
        .environment(viewModel)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                ToolbarSignOutButton(viewModel: $viewModel)
            }
        }
        .confirmationDialog(
            LocaleKeys.Profile.signOutDialog.localized,
            isPresented: $viewModel.showLogoutAlert,
            titleVisibility: .automatic
        ) {
            Button(LocaleKeys.Profile.signOut.localized, role: .destructive) {
                viewModel.logout()
            }
            Button(LocaleKeys.Profile.signOutCancel.localized, role: .cancel) {}
        }
    }
}

struct HeaderView: View {
    @Environment(ProfileViewModel.self) private var viewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: colorScheme == .light ? [.cBlue, .cyan] : [.cGray, .cBlue],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 240)
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)

            VStack(spacing: .low) {
                ProfileImage()
                Text(viewModel.currentUser?.name ?? "User")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .hPadding()
        }
        .allPadding()
    }
}

private struct ProfileImage: View {
    var body: some View {
        Image(systemName: "person.crop.circle.fill")
            .resizable()
            .foregroundColor(.white.opacity(0.8))
            .frame(width: 100, height: 100)
            .background(Circle().fill(.ultraThinMaterial))
            .clipShape(Circle())
            .overlay(Circle().stroke(.white.opacity(0.8), lineWidth: 2))
            .shadow(radius: 5)
    }
}

private struct ProfileRow: View {
    let icon: String
    let title: String
    let value: String?
    var body: some View {
        VStack {
            Divider().background(.cGray)
            HStack(spacing: .normal) {
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .frame(width: 32, height: 32)
                    .background(.cBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                VStack(alignment: .leading) {
                    Text(title.localized)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(value ?? "-")
                        .font(.body)
                        .fontWeight(.medium)
                }

                Spacer()
            }
            .allPadding()
            .background(.cGray)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
        }
    }
}

#Preview {
    NavigationView {
        ProfileView()
    }
}

private struct ProfileDetailsView: View {
    @Environment(ProfileViewModel.self) private var viewModel
    var body: some View {
        VStack(alignment: .leading, spacing: .normal) {
            Text(LocaleKeys.Profile.personalInformation.localized)
                .font(.title3)
                .bold()

            ProfileRow(
                icon: "envelope",
                title: LocaleKeys.Profile.email,
                value: viewModel.currentUser?.email
            )
            ProfileRow(
                icon: "person.fill",
                title: LocaleKeys.Profile.gender,
                value: viewModel.currentUser?.gender?.rawValue
            )
            ProfileRow(
                icon: "calendar",
                title: LocaleKeys.Profile.age,
                value: viewModel.currentUser?.birthDate != nil
                    ? "\(viewModel.calculateAge(from: (viewModel.currentUser?.birthDate!)!))"
                    : nil
            )
            ProfileRow(
                icon: "scalemass",
                title: LocaleKeys.Profile.weight,
                value: "\(viewModel.currentUser?.weight ?? 0) kg"
            )
            ProfileRow(
                icon: "ruler",
                title: LocaleKeys.Profile.height,
                value: "\(viewModel.currentUser?.height ?? 0) cm"
            )
            ProfileRow(
                icon: "target",
                title: LocaleKeys.Profile.goals,
                value: viewModel.currentUser?.goals?.joined(separator: ", ")
            )
            GoalSettingsSection()
                .topPadding(.medium2)
        }
        .hPadding()
    }
}

private struct GoalSettingsSection: View {
    @Environment(GoalManager.self) private var goalManager
    @Environment(ProfileViewModel.self) private var viewModel

    var body: some View {
        @Bindable var viewModel = viewModel
        VStack(alignment: .leading, spacing: .normal) {
            Text("Daily Goals")
                .font(.title3)
                .bold()

            Group {
                Stepper("Step Goal: \(Int(viewModel.stepGoal)) steps", value: $viewModel.stepGoal, in: 1000 ... 50000, step: 500)
                Stepper("Calorie Goal: \(Int(viewModel.calorieGoal)) kcal", value: $viewModel.calorieGoal, in: 100 ... 5000, step: 50)
                Stepper("Sleep Goal: \(viewModel.sleepGoal, specifier: "%.1f") hours", value: $viewModel.sleepGoal, in: 4 ... 12, step: 0.5)
            }
            .padding(.vertical, 8)

            Button("Save Goals") {
                viewModel.saveGoals()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 8)
        }
        .hPadding()
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.cGray)
                .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
        )
//        .padding(.horizontal)
    }
}

private struct ToolbarSignOutButton: View {
    @Binding var viewModel: ProfileViewModel
    var body: some View {
        Button(role: .destructive) {
            viewModel.showLogoutAlert = true
        } label: {
            Image(systemName: "rectangle.portrait.and.arrow.right")
                .foregroundStyle(.cBlue)
        }
    }
}
