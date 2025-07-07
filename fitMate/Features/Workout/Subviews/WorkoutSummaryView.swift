//
//  WorkoutSummaryView.swift
//  fitMate
//
//  Created by Emre Simsek on 19.06.2025.
//

import Charts
import SwiftUI

struct WorkoutSummaryView: View {
    @Environment(UserWorkoutManager.self) private var userWorkoutManager
    var body: some View {
        VStack(spacing: .normal) {
            HStack {
                Spacer()
                SummaryCard2(title: "\(LocaleKeys.Workout.Summary.totalTraining.localized):", value: "\(totalWorkouts)")
                Spacer()
                SummaryCard2(title: "\(LocaleKeys.Workout.Summary.weeklyAverage.localized):", value: "\(weeklyWorkoutAverage)")
                Spacer()
            }
            VStack(spacing: .medium) {
                WorkoutFrequencyChart(logs: userWorkoutManager.logs)
                DailySetChart(data: userWorkoutManager.logs)
            }
        }
        .card(cornerRadius: .low, padding: .normal)
        .background(.cBackground)
    }
}

struct DailySetChart: View {
    let data: [WorkoutLog]

    var body: some View {
        Chart(data) {
            LineMark(
                x: .value(LocaleKeys.Workout.Summary.setChartDate.localized, $0.date, unit: .day),
                y: .value(LocaleKeys.Workout.Summary.setChartSets.localized, $0.calculateTotalSets())
            )
            .interpolationMethod(.catmullRom)
            .foregroundStyle(.cBlue)
            .symbol(Circle())
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { _ in
                AxisValueLabel(format: .dateTime.day().month(.abbreviated))
            }
        }
        .frame(height: .dynamicHeight(height: 0.075))
    }
}

private struct SummaryCard2: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .center, spacing: .low3) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
        }
    }
}

private struct WorkoutFrequencyChart: View {
    let logs: [WorkoutLog]

    var body: some View {
        let grouped = Dictionary(grouping: logs) {
            Calendar.current.component(.weekday, from: $0.date)
        }

        let data = (1 ... 7).map { weekday -> (String, Int) in
            let dayName = DateFormatter().shortWeekdaySymbols[weekday - 1]
            return (dayName, grouped[weekday]?.count ?? 0)
        }

        Chart {
            ForEach(data, id: \.0) { day, count in
                BarMark(
                    x: .value(LocaleKeys.Workout.Summary.workoutFrequencyDay.localized, day),
                    y: .value(LocaleKeys.Workout.Summary.workoutFrequencyWorkouts.localized, count)
                )
            }
        }.foregroundStyle(.cBlue)
            .frame(height: .dynamicHeight(height: 0.075))
    }
}

extension WorkoutSummaryView {
    var totalWorkouts: Int { userWorkoutManager.logs.count }

    var lastWorkoutDate: Date? {
        userWorkoutManager.logs.map(\.date).max()
    }

    var weeklyWorkoutAverage: Double {
        let last4Weeks = Calendar.current.date(byAdding: .weekOfYear, value: -4, to: .now)!
        let recentLogs = userWorkoutManager.logs.filter { $0.date >= last4Weeks }
        let grouped = Dictionary(grouping: recentLogs) { Calendar.current.component(.weekOfYear, from: $0.date) }
        return Double(grouped.map(\.value).count) / 4.0
    }
}

#Preview {
    NavigationStack {
        WorkoutSummaryView()
            .background(.cBackground)
            .environment(AppContainer.shared.userWorkoutManager)
            .allPadding()
    }
}
