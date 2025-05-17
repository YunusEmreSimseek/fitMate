//
//  GoalView.swift
//  fitMate
//
//  Created by Emre Simsek on 3.11.2024.
//

import SwiftUI

struct GoalView: View {
    var body: some View {
        VStack {
            TopTitlesColumn()
            Spacer()
            VStack(spacing: .normal) {
                GoalCardView(goal: .loseWeight)
                GoalCardView(goal: .getFitter)
                GoalCardView(goal: .gainMuscles)
            }

            Spacer()
        }
        .vPadding()
        .background(.cBackground)
        .ignoresSafeArea()
    }
}

#Preview {
    GoalView()
//        .environment(OnboardViewModel())
}

private struct TopTitlesColumn: View {
    var body: some View {
        VStack(spacing: .low) {
            Text(LocaleKeys.Onboard.Goal.title.localized)
                .font(.title)
                .bold()
            Text(LocaleKeys.Onboard.subTitle.localized)
        }
    }
}

private struct GoalCardView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(OnboardViewModel.self) private var viewModel
    let goal: GoalModel
    var body: some View {
        if viewModel.selectedGoals.contains(goal.title) {
            HStack {
                VStack(alignment: .leading) {
                    Text(goal.title)
                        .font(.title3)
                        .bold()
                    Text(goal.subTitle)
                        .font(.subheadline)
                }
                Spacer()
                Image(goal.image)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.placeholder)
            }
            .allPadding()
            .background(.cBlue)
            .clipShape(.rect(cornerRadius: .normal))
            .frame(height: .dynamicHeight(height: 0.12))
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 2)
            }
            .onTapGesture {
                viewModel.disSelectGoal(goal: goal)
            }
        } else {
            HStack {
                VStack(alignment: .leading) {
                    Text(goal.title)
                        .font(.title3)
                        .bold()
                    Text(goal.subTitle)
                        .font(.subheadline)
                }
                Spacer()
                Image(goal.image)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.placeholder)
            }
            .allPadding()
            .frame(height: .dynamicHeight(height: 0.12))
            .background(.cGray)
            .clipShape(.rect(cornerRadius: .normal))
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 2)
            }
            .onTapGesture {
                viewModel.selectGoal(goal: goal)
            }
        }
    }
}
