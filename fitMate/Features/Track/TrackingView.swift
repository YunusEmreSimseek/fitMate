//
//  TrackingView.swift
//  fitMate
//
//  Created by Emre Simsek on 12.06.2025.
//

import SwiftUI

struct TrackingView: View {
    @State private var dietViewModel: DietViewModel = .init()
    @State private var workoutViewModel: WorkoutViewModel = .init()
    @State private var state: TrackingState = .workout
    var body: some View {
        VStack(spacing: .zero) {
            ZStack(alignment: .trailing) {
                HStack {
                    Spacer().frame(maxWidth: .infinity)
                    Picker(LocaleKeys.Tracking.type.localized, selection: $state) {
                        Text(LocaleKeys.Diet.title.localized).tag(TrackingState.diet)
                        Text(LocaleKeys.Workout.title.localized).tag(TrackingState.workout)
                    }
                    .pickerStyle(.segmented)
                    Spacer().frame(maxWidth: .infinity)
                }.frame(maxWidth: .infinity)

                Group {
                    if state == .diet {
                        DietToolbarMenu()
                    } else {
                        WorkoutToolbarMenu()
                    }
                }.trailingPadding(.normal)
            }
            if state == .diet {
                DietView()
            } else {
                WorkoutView()
            }
        }
        .environment(dietViewModel)
        .environment(workoutViewModel)
        .background(.cBackground)
    }
}

enum TrackingState {
    case diet
    case workout
}

#Preview {
    NavigationStack {
        TrackingView()
    }
}
