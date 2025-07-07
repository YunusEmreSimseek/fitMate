//
//  GoalModel.swift
//  fitMate
//
//  Created by Emre Simsek on 5.11.2024.
//

import SwiftUI

struct GoalModel: Identifiable, Equatable {
    let id: UUID = .init()
    let title: String
    let subTitle: String
    let image: ImageResource
}

extension GoalModel {
    static let loseWeight = GoalModel(title: LocaleKeys.Onboard.Goal.loseWeightTitle.localized, subTitle: LocaleKeys.Onboard.Goal.loseWeightSubTitle.localized, image: .burn)

    static let getFitter = GoalModel(title: LocaleKeys.Onboard.Goal.getFitterTitle.localized, subTitle: LocaleKeys.Onboard.Goal.getFitterSubTitle.localized, image: .heartbeat)

    static let gainMuscles = GoalModel(title: LocaleKeys.Onboard.Goal.gainMusclesTitle.localized, subTitle: LocaleKeys.Onboard.Goal.gainMusclesSubTitle.localized, image: .dumbell)
}
