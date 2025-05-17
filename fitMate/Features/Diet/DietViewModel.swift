//
//  DietViewModel.swift
//  fitMate
//
//  Created by Emre Simsek on 30.04.2025.
//

import Foundation

@Observable
final class DietViewModel {
    var dietPlan: DietModel?
    var isLoading = false
    var showStartSheet = false

    private let userSessionManager: UserSessionManager
    private let dietService: DietService
    private let navigationManager: NavigationManager

    init(
        userSessionManager: UserSessionManager = AppContainer.shared.userSessionManager,
        dietService: DietService = AppContainer.shared.dietService,
        navigationManager: NavigationManager = AppContainer.shared.navigationManager
    ) {
        self.userSessionManager = userSessionManager
        self.dietService = dietService
        self.navigationManager = navigationManager
        isPreview()
    }

    func loadDietPlan() async {
        guard let userId = userSessionManager.currentUser?.id else { return }
        isLoading = true
        defer { isLoading = false }
        dietPlan = await dietService.fetchDiet(for: userId)
    }

    func saveDietPlan(_ plan: DietModel) async {
        guard let userId = userSessionManager.currentUser?.id else { return }
        isLoading = true
        defer { isLoading = false }
        await dietService.saveDiet(plan, for: userId)
        dietPlan = plan
    }

    func isPreview() {
        if AppMode.isPreview {
            dietPlan = DietModel.dummyDiet
        }
    }
}
