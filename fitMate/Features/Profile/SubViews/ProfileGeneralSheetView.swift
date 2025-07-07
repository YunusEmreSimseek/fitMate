//
//  ProfileGeneralSheetView.swift
//  fitMate
//
//  Created by Emre Simsek on 17.06.2025.
//

import SwiftUI

struct ProfileGeneralSheetView: View {
    @Environment(UserSessionManager.self) private var userSessionManager
    @Environment(ProfileViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: .medium3) {
            ScrollView {
                VStack(spacing: .medium3) {
                    Text(LocaleKeys.Profile.GeneralSheet.title.localized).font(.title3).bold()
                    NameSection()
                    EmailSection()
                    HStack {
                        WeightSection()
                        Spacer()
                        HeightSection()
                        Spacer()
                        GenderSection()
                    }
                    BirthdaySection()
                    HStack(spacing: .normal) {
                        GoalSection()
                        Spacer()
                        FitnessLevelSection()
                    }
                    StepGoalSection()

                    BottomTextSection()
                }
                .hPadding(.low3)
                .bottomPadding(.low)
            }

            RoundedRectangelButton2(title: LocaleKeys.Button.save.localized, disabled: !viewModel.checkForUpdates, onTap: {
                Task {
                    await viewModel.updateUser()
                }
                dismiss()
                viewModel.showUserUpdateSuccessSnackbar = true
            })
        }

        .allPadding()
        .background(.cBackground)
    }
}

private struct NameSection: View {
    @Environment(UserSessionManager.self) private var userSessionManager
    @Environment(ProfileViewModel.self) private var viewModel
    @State private var name: String = ""
    var body: some View {
        VStack(alignment: .leading, spacing: .low3) {
            Text(LocaleKeys.Profile.GeneralSheet.nameTitle.localized).font(.subheadline).fontWeight(.semibold).foregroundStyle(.secondary)
            TextField(LocaleKeys.Profile.GeneralSheet.namePlaceholder.localized, text: $name)
                .card(cornerRadius: .low, padding: .low)
                .contentShape(Rectangle())
        }.onAppear {
            if let userName = userSessionManager.currentUser?.name {
                name = userName
            }
        }
        .onChange(of: name) { _, newValue in
            viewModel.updatedUser?.name = newValue
        }
    }
}

private struct EmailSection: View {
    @Environment(UserSessionManager.self) private var userSessionManager
    @Environment(ProfileViewModel.self) private var viewModel
    @State private var email: String = ""
    var body: some View {
        VStack(alignment: .leading, spacing: .low3) {
            Text(LocaleKeys.Profile.GeneralSheet.emailTitle.localized).font(.subheadline).fontWeight(.semibold).foregroundStyle(.secondary)
            TextField(LocaleKeys.Profile.GeneralSheet.emailPlaceholder.localized, text: $email)
                .card(cornerRadius: .low, padding: .low)
                .contentShape(Rectangle())
        }
        .onAppear {
            if let userEmail = userSessionManager.currentUser?.email {
                email = userEmail
            }
        }
    }
}

private struct WeightSection: View {
    @Environment(UserSessionManager.self) private var userSessionManager
    @Environment(ProfileViewModel.self) private var viewModel
    @State private var weight: String = ""
    var body: some View {
        VStack(alignment: .leading, spacing: .low3) {
            Text(LocaleKeys.Profile.GeneralSheet.weightTitle.localized).font(.subheadline).fontWeight(.semibold).foregroundStyle(.secondary)
            TextField(LocaleKeys.Profile.GeneralSheet.weightPlaceholder.localized, text: $weight)
                .keyboardType(.numberPad)
                .card(cornerRadius: .low, padding: .low)
                .contentShape(Rectangle())
        }
        .onAppear {
            if let userWeight = userSessionManager.currentUser?.weight {
                weight = String(userWeight)
            }
        }
        .onChange(of: weight) { _, newValue in
            if let weightValue = Int(newValue) {
                viewModel.updatedUser?.weight = weightValue
            } else {
                viewModel.updatedUser?.weight = nil
            }
        }
    }
}

private struct HeightSection: View {
    @Environment(UserSessionManager.self) private var userSessionManager
    @Environment(ProfileViewModel.self) private var viewModel
    @State private var height: String = ""
    var body: some View {
        VStack(alignment: .leading, spacing: .low3) {
            Text(LocaleKeys.Profile.GeneralSheet.heightTitle.localized).font(.subheadline).fontWeight(.semibold).foregroundStyle(.secondary)
            TextField(LocaleKeys.Profile.GeneralSheet.heightPlaceholder.localized, text: $height)
                .keyboardType(.numberPad)
                .card(cornerRadius: .low, padding: .low)
                .contentShape(Rectangle())
        }
        .onAppear {
            if let userHeight = userSessionManager.currentUser?.height {
                height = String(userHeight)
            }
        }
        .onChange(of: height) { _, newValue in
            if let heightValue = Int(newValue) {
                viewModel.updatedUser?.height = heightValue
            } else {
                viewModel.updatedUser?.height = nil
            }
        }
    }
}

private struct BirthdaySection: View {
    @Environment(UserSessionManager.self) private var userSessionManager
    @Environment(ProfileViewModel.self) private var viewModel
    @State private var birthday: Date = .now
    var body: some View {
        HStack {
            Text(LocaleKeys.Profile.GeneralSheet.birthdayTitle.localized).font(.subheadline).fontWeight(.semibold).foregroundStyle(.secondary)
            Spacer()
            DatePicker("", selection: $birthday, displayedComponents: .date)
                .datePickerStyle(.compact)
                .labelsHidden()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .card(cornerRadius: .low, padding: .low3)
        .onAppear {
            if let userBirthday = userSessionManager.currentUser?.birthDate {
                birthday = userBirthday
            }
        }
        .onChange(of: birthday) { _, newValue in
            viewModel.updatedUser?.birthDate = newValue
        }
    }
}

private struct GenderSection: View {
    @Environment(UserSessionManager.self) private var userSessionManager
    @Environment(ProfileViewModel.self) private var viewModel
    @State private var selectedGender: Gender? = nil
    var body: some View {
        VStack(alignment: .leading, spacing: .low3) {
            Text(LocaleKeys.Profile.GeneralSheet.genderTitle.localized).font(.subheadline).fontWeight(.semibold).foregroundStyle(.secondary)
            //            Spacer()
            CustomPicker(selected: $selectedGender, options: Gender.allCases)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .card(cornerRadius: .low, padding: .low)
        }
        .onAppear {
            if let userGender = userSessionManager.currentUser?.gender {
                selectedGender = userGender
            }
        }
        .onChange(of: selectedGender) { _, newValue in
            viewModel.updatedUser?.gender = newValue
        }
    }
}

private struct FitnessLevelSection: View {
    @Environment(UserSessionManager.self) private var userSessionManager
    @Environment(ProfileViewModel.self) private var viewModel
    @State private var selectedLevel: FitnessLevel? = nil
    var body: some View {
        VStack(alignment: .leading, spacing: .low3) {
            Text(LocaleKeys.Profile.GeneralSheet.fitnessLevelTitle.localized).font(.subheadline).fontWeight(.semibold).foregroundStyle(.secondary)
            //            Spacer()
            CustomPicker(selected: $selectedLevel, options: FitnessLevel.allCases)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .card(cornerRadius: .low, padding: .low)
        }
        .onAppear {
            if let userLevel = userSessionManager.currentUser?.fitnessLevel {
                selectedLevel = userLevel
            }
        }
        .onChange(of: selectedLevel) { _, newValue in
            viewModel.updatedUser?.fitnessLevel = newValue
        }
    }
}

private struct GoalSection: View {
    @Environment(UserSessionManager.self) private var userSessionManager
    @Environment(ProfileViewModel.self) private var viewModel
    @State private var selectedGoal: Goal = .maintainWeight
    @State private var goals: [Goal] = []
    var body: some View {
        VStack(alignment: .leading, spacing: .low3) {
            Text(LocaleKeys.Profile.GeneralSheet.goalsTitle.localized).font(.subheadline).fontWeight(.semibold).foregroundStyle(.secondary)
            CustomMultiPicker(selecteds: $goals, options: Goal.allCases)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .card(cornerRadius: .low, padding: .low)
        }
        .onAppear {
            if let userGoals = userSessionManager.currentUser?.goals {
                goals = userGoals
            }
        }
        .onChange(of: goals) { _, newValue in
            viewModel.updatedUser?.goals = newValue
        }
    }
}

private struct StepGoalSection: View {
    @Environment(UserSessionManager.self) private var userSessionManager
    @Environment(ProfileViewModel.self) private var viewModel
    @State private var stepGoal: Double = 6000
    let minStepGoal: Int = 2000
    let maxStepGoal: Int = 20000
    let increaseStepGoal: Int = 1000

    var body: some View {
        VStack(alignment: .leading, spacing: .low3) {
            Text(LocaleKeys.Profile.GeneralSheet.stepGoalTitle.localized).font(.subheadline).fontWeight(.semibold).foregroundStyle(.secondary)

            VStack(alignment: .center, spacing: 4) {
                Text("\(Int(stepGoal)) \(LocaleKeys.Measurement.steps.localized)")
                    .font(.headline)
                    .bold()
                    .foregroundStyle(.cBlue)
                Slider(value: $stepGoal, in: Double(minStepGoal) ... Double(maxStepGoal), step: Double.Stride(increaseStepGoal))
                    .tint(.cBlue)
                    .controlSize(.small)

                HStack {
                    Text("\(minStepGoal)")
                    Spacer()
                    Text("\(maxStepGoal)")
                }
                .font(.footnote)
            }.card(cornerRadius: .low, padding: .low)
        }
        .onAppear {
            if let userStepGoal = userSessionManager.currentUser?.stepGoal {
                stepGoal = Double(userStepGoal)
            }
        }
        .onChange(of: stepGoal) { _, newValue in
            viewModel.updatedUser?.stepGoal = Int(newValue)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private struct BottomTextSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: .low3) {
            Text("\(LocaleKeys.Profile.GeneralSheet.privacyPolicyTitle.localized):").font(.headline)
            Text(LocaleKeys.Profile.GeneralSheet.privacyPolicyText.localized)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }.card(cornerRadius: .low)
    }
}

private struct CustomPicker<T: Pickable & CaseIterable & Identifiable>: View {
    @Binding var selected: T?
    let options: [T]

    var body: some View {
        Menu {
            ForEach(options) { option in
                Button(action: {
                    if selected?.id == option.id {
                        selected = nil
                    } else {
                        selected = option
                    }
                }) {
                    HStack {
                        if selected?.id == option.id {
                            Image(systemName: "checkmark")
                        }
                        Text(option.title.capitalized)
                            //                            .font(.subheadline)
                            .tint(.primary)
                    }
                }
            }
        } label: {
            HStack {
                Text(selected?.title.capitalized ?? "None")

                Image(systemName: "chevron.down")
            }
            .tint(.primary)
            //            .font(.subheadline)
        }
    }
}

private struct CustomMultiPicker<T: Pickable & CaseIterable & Identifiable>: View {
    @Binding var selecteds: [T]
    let options: [T]

    var body: some View {
        Menu {
            ForEach(options) { option in
                Button(action: {
                    if selecteds.contains(where: { $0.id == option.id }) {
                        selecteds.removeAll(where: { $0.id == option.id })
                    } else {
                        selecteds.append(option)
                    }
                }) {
                    HStack {
                        ForEach(selecteds) { selected in
                            if selected.id == option.id {
                                Image(systemName: "checkmark")
                            }
                        }
                        Text(option.title.capitalized)
                            .tint(.primary)
                    }
                }
            }
        } label: {
            HStack {
                Text(selecteds.last?.title.capitalized ?? "None")

                Image(systemName: "chevron.down")
            }
            .tint(.primary)
        }
    }
}

#Preview {
    ProfileGeneralSheetView()
        .environment(UserSessionManager())
        .environment(ProfileViewModel())
}
