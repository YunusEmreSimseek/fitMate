//
//  PhysicalView.swift
//  fitMate
//
//  Created by Emre Simsek on 3.11.2024.
//

import SwiftUI

struct PhysicalView: View {
    @Environment(OnboardViewModel.self) private var viewModel
    var body: some View {
        @Bindable var viewModel = viewModel
        VStack {
            TopTitlesColumn()
//            Spacer(minLength: .high3)
            Spacer()
            VStack {
                HeightColumn()
                WeightColumn()
            }
            Spacer()
        }
        .vPadding()
        .background(.cBackground)
//        .ignoresSafeArea()
    }
}

private struct TopTitlesColumn: View {
    var body: some View {
        VStack(spacing: .low) {
            Text(LocaleKeys.Onboard.Physical.title.localized)
                .font(.title)
                .bold()
            Text(LocaleKeys.Onboard.subTitle.localized)
        }
    }
}

private struct HeightColumn: View {
    @Environment(OnboardViewModel.self) private var viewModel
    var body: some View {
        @Bindable var viewModel = viewModel
        VStack {
            Divider()
                .background(.foreground)
            HStack {
                Text(LocaleKeys.Onboard.Physical.height.localized)
                    .font(.title2)
                    .bold()
                Picker("", selection: $viewModel.selectedHeight) {
                    ForEach(100 ... 250, id: \.self) { height in
                        Text("\(height) cm")
                    }
                }
                .pickerStyle(.wheel)
            }
            Divider()
                .background(.foreground)
        }
        .frame(minHeight: .dynamicHeight(height: 0.175))
    }
}

private struct WeightColumn: View {
    @Environment(OnboardViewModel.self) private var viewModel
    var body: some View {
        @Bindable var viewModel = viewModel

        VStack {
            HStack {
                Text(LocaleKeys.Onboard.Physical.weight.localized)
                    .font(.title2)
                    .bold()
                Picker("", selection: $viewModel.selectedWeight) {
                    ForEach(40 ... 200, id: \.self) { weight in
                        Text("\(weight) kg")
                    }
                }
                .pickerStyle(.wheel)
            }
            Divider()
                .background(.foreground)
        }
        .frame(minHeight: .dynamicHeight(height: 0.175))
    }
}
