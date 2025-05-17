//
//  GenderView.swift
//  fitMate
//
//  Created by Emre Simsek on 3.11.2024.
//

import SwiftUI

struct GenderView: View {
    @Environment(OnboardViewModel.self) private var viewModel
    var body: some View {
        @Bindable var viewModel = viewModel
        VStack {
            TopTitlesColumn()
            Spacer()
            CenterGenderRow()
            Spacer()
            BottomDatePickerView()
        }
        .vPadding()
        .background(.cBackground)
        .ignoresSafeArea()
    }
}

private struct TopTitlesColumn: View {
    var body: some View {
        VStack(spacing: .low) {
            Text(LocaleKeys.Onboard.Gender.title.localized)
                .multilineTextAlignment(.center)
                .font(.title)
                .bold()
            Text(LocaleKeys.Onboard.subTitle.localized)
        }
    }
}

private struct CenterGenderRow: View {
    @Environment(OnboardViewModel.self) private var viewModel
    var body: some View {
        VStack(spacing: .normal) {
            HStack(spacing: .normal) {
                MaleGenderCard()
                FemaleGenderCard()
            }
            Text(LocaleKeys.Onboard.Gender.bottomText.localized)
                .foregroundStyle(.primary)
        }
    }
}

private struct GenderCard: View {
    let isSelected: Bool
    let genderImage: Image
    let color: Color
    let label: String
    let action: () -> Void

    var body: some View {
        VStack {
            Rectangle()
                .fill(isSelected ? .primary : Color.clear)
                .frame(height: .dynamicHeight(height: 0.1))
                .clipShape(RoundedRectangle(cornerRadius: .normal))
                .overlay(
                    RoundedRectangle(cornerRadius: .normal)
                        .stroke(isSelected ? Color.clear : Color.primary, lineWidth: isSelected ? 0 : 3.5)
                )
                .overlay {
                    genderImage
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(isSelected ? color : .primary)
                        .frame(height: .dynamicHeight(height: 0.07))
                }
                .onTapGesture {
                    withAnimation { action() }
                }
                .hPadding()

            Text(label)
                .font(.title3)
                .bold()
        }
    }
}

private struct MaleGenderCard: View {
    @Environment(OnboardViewModel.self) private var viewModel
    var body: some View {
        GenderCard(isSelected: viewModel.selectedGender == .male, genderImage: Image(.male), color: .cBlue, label: LocaleKeys.Onboard.Gender.male.localized) {
            viewModel.changeGender(gender: .male)
        }
    }
}

private struct FemaleGenderCard: View {
    @Environment(OnboardViewModel.self) private var viewModel
    var body: some View {
        GenderCard(isSelected: viewModel.selectedGender == .female, genderImage: Image(.female), color: .purple, label: LocaleKeys.Onboard.Gender.female.localized) {
            viewModel.changeGender(gender: .female)
        }
    }
}

private struct BottomDatePickerView: View {
    @Environment(OnboardViewModel.self) private var viewModel
    var body: some View {
        @Bindable var viewModel = viewModel
        VStack {
            Text(LocaleKeys.Onboard.Gender.secondTitle.localized)
                .font(.title2)
                .bold()
            DatePicker(
                "", selection: $viewModel.selectedDate,
                displayedComponents: .date
            )
            .datePickerStyle(.wheel)
            .labelsHidden()
            .onChange(of: viewModel.selectedDate) { _, newDate in
                viewModel.selectedDate = newDate
            }
        }
    }
}
