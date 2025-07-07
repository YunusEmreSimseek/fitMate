//
//  ExerciseListView.swift
//  fitMate
//
//  Created by Emre Simsek on 12.06.2025.
//

import SwiftUI

struct ExerciseListView: View {
    @State private var viewModel: ExerciseListViewModel = .init()
    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach(viewModel.userWorkoutManager.selectedDay?.exercises ?? []) { ex in
                ExerciseView(ex)
                    .contentShape(Rectangle())
                    .swipeActions(edge: .trailing) { SwipeDeleteButton { viewModel.onDeleteExercise(ex) } }
                    .contextMenu {
                        Button(role: .destructive) {
                            viewModel.onDeleteExercise(ex)
                        } label: {
                            Label(LocaleKeys.Button.delete.localized, systemImage: "trash")
                        }
                    }
                    .alert(LocaleKeys.Workout.Exercise.deleteAlertTitle.localized, isPresented: $viewModel.showDeleteExerciseConfirmation) {
                        AlertDeleteButtons { await viewModel.deleteExercise() }
                    }
                    .onTapGesture { viewModel.onTapExercise(ex) }
                    .sheet(isPresented: $viewModel.showEditExerciseSheet) {
                        EditWorkoutExerciseView(viewModel.selectedExercise!) { updated in
                            Task { await viewModel.updateExercise(updated) }
                        }
                        .presentationDetents([.medium, .large])
                    }
                Divider()
            }
        }
        .hPadding(.low)
        .vPadding(.low3)
    }
}

private struct ExerciseView: View {
    let ex: WorkoutExercise
    init(_ ex: WorkoutExercise) {
        self.ex = ex
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(ex.name).font(.footnote).fontWeight(.semibold)
            Text("\(ex.sets)x\(ex.reps) \(ex.weight, specifier: "%.1f") \(StringConstants.bodyWeightMeasurement)")
                .font(.footnote)
                .foregroundColor(.gray)
            if let note = ex.notes {
                Text(note).font(.caption).foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    ExerciseListView()
}
