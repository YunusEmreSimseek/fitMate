//
//  ActiveDietDashboardView.swift
//  fitMate
//
//  Created by Emre Simsek on 17.05.2025.
//

import SwiftUI

struct ActiveDietDashboardView: View {
    @State private var viewModel: ActiveDietDashboradViewModel = .init()

    var body: some View {
        @Bindable var viewModel = viewModel
        ScrollView {
            VStack(spacing: .medium3) {
                DietSummaryCard()

                AverageProgressCard()

                DailyDietLogList()
            }
            .padding()
        }
        .sheet(item: $viewModel.selectedLog) { log in
            DietLogDetailSheet(log: log)
        }
        .sheet(isPresented: $viewModel.showLogSheet) {
            AddDailyDietLogSheet()
        }
        .task {}
        .environment(viewModel)
        .modifier(CenterLoadingViewModifier(isLoading: viewModel.isLoading))
    }
}

#Preview {
    NavigationStack {
        ActiveDietDashboardView()
    }
}
