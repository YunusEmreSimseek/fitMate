//
//  ProfileView.swift
//  fitMate
//
//  Created by Emre Simsek on 17.06.2025.
//

import SwiftUI

struct ProfileView: View {
    @State private var viewModel: ProfileViewModel = .init()
    var body: some View {
        ScrollView {
            VStack(spacing: .medium3) {
                HeaderSection()

                SummaryRow()

                GeneralSection()

                SupportUsSection()

                OthersSection()
            }.allPadding()
        }
        .background(.cBackground)
        .navigationTitle(LocaleKeys.Profile.title.localized)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $viewModel.showGeneralSheet, content: {
            ProfileGeneralSheetView().presentationCornerRadius(.normal)
        })
        .sheet(isPresented: $viewModel.showNotificationSheet, content: {
            ProfileNotificationSheetView().presentationDetents([.medium]).presentationCornerRadius(.normal)
        })
        .sheet(isPresented: $viewModel.showUnitsSheet, content: {
            ProfileUnitsSheetView().presentationDetents([.medium]).presentationCornerRadius(.normal)
        })
        .alert(isPresented: $viewModel.showLogoutAlert) {
            Alert(title: Text(LocaleKeys.Profile.signOut.localized),
                  message: Text(LocaleKeys.Profile.signOutDialog.localized),
                  primaryButton: .destructive(Text(LocaleKeys.Profile.signOut.localized)) {
                      viewModel.signOut()
                  },
                  secondaryButton: .cancel())
        }
        .snackBar(isPresented: $viewModel.showUserUpdateSuccessSnackbar, message: LocaleKeys.Profile.updateConfirmation.localized)
        .environment(viewModel)
    }
}

private struct HeaderSection: View {
    @Environment(UserSessionManager.self) private var userSessionManager
    var body: some View {
        VStack(spacing: .low2) {
            ProfileUserImage()
            Text(userSessionManager.currentUser?.name ?? "FitMate").font(.headline)
        }
        .vPadding(.low3)
    }
}

private struct SummaryRow: View {
    @Environment(UserWorkoutManager.self) private var userWorkoutManager
    @Environment(UserDietManager.self) private var userDietManager
    var body: some View {
        VStack(alignment: .leading) {
            Text(LocaleKeys.Profile.Summary.title.localized).font(.subheadline).fontWeight(.semibold).foregroundStyle(.secondary)

            HStack {
                ProfileSummaryCard(icon: "figure.strengthtraining.traditional", value: "\(userWorkoutManager.calculateWorkoutThisWeek())", title: LocaleKeys.Profile.Summary.workouts.localized)
                Spacer()
                ProfileSummaryCard(icon: "fork.knife", value: "\(userDietManager.calculateThisWeeksLogCount())", title: "Logs")
                Spacer()
                ProfileSummaryCard(icon: "figure.walk", value: "\(userDietManager.weeklyStepCount())", title: LocaleKeys.Profile.Summary.steps.localized)
            }
        }
        .hPadding(.low3)
    }
}

private struct GeneralSection: View {
    @Environment(ProfileViewModel.self) private var viewModel
    var body: some View {
        VStack(alignment: .leading, spacing: .low2) {
            Text(LocaleKeys.Profile.General.title.localized).font(.subheadline).fontWeight(.semibold).foregroundStyle(.secondary)

            VStack(spacing: .normal) {
                ProfileSectionChevronRow(icon: "person.fill", title: LocaleKeys.Profile.General.settings.localized)
                    .onTapGesture { viewModel.showGeneralSheet = true }
                ProfileSectionBothRow(icon: "sparkles", title: LocaleKeys.Profile.General.credits.localized, text: "150")
                ProfileSectionChevronRow(icon: "bell.fill", title: LocaleKeys.Profile.General.notifications.localized)
                    .onTapGesture { viewModel.showNotificationSheet = true }
                ProfileSectionBothRow(icon: "globe", title: LocaleKeys.Profile.General.language.localized, text: "English")
                ProfileSectionChevronRow(icon: "scalemass.fill", title: LocaleKeys.Profile.General.units.localized)
                    .onTapGesture { viewModel.showUnitsSheet = true }
            }
            .card(bgColor: .cGray)
        }.hPadding(.low3)
    }
}

private struct SupportUsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: .low2) {
            Text(LocaleKeys.Profile.SupportUs.title.localized).font(.subheadline).fontWeight(.semibold).foregroundStyle(.secondary)

            VStack(spacing: .normal) {
                ProfileSectionChevronRow(icon: "square.and.arrow.up.fill", title: LocaleKeys.Profile.SupportUs.share.localized)
                ProfileSectionChevronRow(icon: "star.fill", title: LocaleKeys.Profile.SupportUs.rate.localized)
                ProfileSectionChevronRow(icon: "gift.fill", title: LocaleKeys.Profile.SupportUs.tip.localized)
            }
            .card(bgColor: .cGray)
        }.hPadding(.low3)
    }
}

private struct OthersSection: View {
    @Environment(ProfileViewModel.self) private var viewModel
    var body: some View {
        VStack(alignment: .leading, spacing: .low2) {
            Text(LocaleKeys.Profile.Others.title.localized).font(.subheadline).fontWeight(.semibold).foregroundStyle(.secondary)

            VStack(spacing: .normal) {
                ProfileSectionTextRow(icon: "dumbbell.fill", title: LocaleKeys.Profile.Others.appName.localized, text: "FitMate")
                ProfileSectionTextRow(icon: "info.circle.fill", title: LocaleKeys.Profile.Others.version.localized, text: "1.0.0")
                ProfileSectionChevronRow(icon: "lock.shield.fill", title: LocaleKeys.Profile.Others.privacyPolicy.localized)
                ProfileSectionChevronRow(icon: "arrow.right.square.fill", title: LocaleKeys.Profile.Others.signOut.localized)
                    .onTapGesture {
                        viewModel.showLogoutAlert = true
                    }
            }
            .card(bgColor: .cGray)
        }.hPadding(.low3).bottomPadding(.low3)
    }
}

#Preview {
    NavigationStack {
        ProfileView()
            .environment(UserSessionManager())
            .environment(ProfileViewModel())
            .environment(UserWorkoutManager())
            .environment(UserDietManager())
            .environment(HealthKitManager())
            .environment(UnitManager())
    }
}
