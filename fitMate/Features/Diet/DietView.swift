//
//  DietView.swift
//  fitMate
//
//  Created by Emre Simsek on 30.04.2025.
//

import SwiftUI

struct DietView: View {
    @State private var viewModel: DietViewModel = .init()
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Yükleniyor...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let plan = viewModel.dietPlan {
                ActiveDietPlanView(plan: plan)
            } else {
                EmptyDietStateView()
            }
        }
        .navigationTitle("Diyet")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadDietPlan()
        }
        .environment(viewModel)
        .sheet(isPresented: $viewModel.showStartSheet) {
            StartDietPlanSheet()
        }
    }
}

private struct EmptyDietStateView: View {
    @Environment(DietViewModel.self) private var viewModel

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "leaf.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .foregroundStyle(.cBlue)

            Text("Henüz bir diyet süreci başlatmadın.")
                .multilineTextAlignment(.center)
                .font(.title3)
                .padding()

            Button("Diyet Süreci Başlat") {
                viewModel.showStartSheet = true
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private struct ActiveDietPlanView: View {
    let plan: DietModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .medium2) {
                Text("Hedeflerin")
                    .font(.headline)

                Group {
                    Text("Süre: \(plan.durationInDays) gün")
                    Text("Hedef Kilo: \(plan.targetWeight, specifier: "%.1f") kg")
                    Text("Günlük Adım: \(plan.dailyStepGoal)")
                    Text("Günlük Kalori: \(plan.dailyCalorieLimit) kcal")
                    Text("Protein Hedefi: \(plan.dailyProteinGoal) g")
                }

                Button("Bugünün Kaydını Gir") {
                    // gün kaydı sayfasına git
                }

                Button("Geçmiş Günleri Gör") {
                    // history ekranına git
                }
            }
            .padding()
        }
    }
}

private struct StartDietPlanSheet: View {
    @Environment(DietViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss

    @State private var duration = 30
    @State private var weightLoss = 5.0
    @State private var targetWeight = 70.0
    @State private var dailySteps = 10000
    @State private var dailyCalories = 2200
    @State private var dailyProtein = 100
    @State private var dailyWater = 2.5

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Süre")) {
                    Stepper("Diyet Süresi: \(duration) gün", value: $duration, in: 7 ... 120)
                }

                Section(header: Text("Kilo Hedefi")) {
                    HStack {
                        Text("Hedef Kilo Kaybı:")
                        Spacer()
                        TextField("kg", value: $weightLoss, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 80)
                    }

                    HStack {
                        Text("Hedef Kilonuz:")
                        Spacer()
                        TextField("kg", value: $targetWeight, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 80)
                    }
                }

                Section(header: Text("Günlük Hedefler")) {
                    LabeledIntField(label: "Adım Sayısı", value: $dailySteps, unit: "adım")
                    LabeledIntField(label: "Kalori Limiti", value: $dailyCalories, unit: "kcal")
                    LabeledIntField(label: "Protein Hedefi", value: $dailyProtein, unit: "gram")
                }

                Button("Diyet Sürecini Başlat") {
                    Task {
                        let plan = DietModel(
                            startDate: .now,
                            durationInDays: duration,
                            weightLossGoalKg: weightLoss,
                            targetWeight: targetWeight,
                            dailyStepGoal: dailySteps,
                            dailyCalorieLimit: dailyCalories,
                            dailyProteinGoal: dailyProtein
                        )
                        await viewModel.saveDietPlan(plan)
                        dismiss()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Diyet Süreci Başlat")
        }
    }
}

struct LabeledIntField: View {
    let label: String
    @Binding var value: Int
    let unit: String

    var body: some View {
        HStack {
            Text(label)
            Spacer()
            TextField(unit, value: $value, format: .number)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.trailing)
                .frame(width: 80)
        }
    }
}

#Preview {
    DietView()
        .environment(DietViewModel())
}
