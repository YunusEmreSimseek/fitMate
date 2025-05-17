//
//  NavigationManager.swift
//  fitMate
//
//  Created by Emre Simsek on 3.11.2024.
//

import SwiftUI

@Observable
final class NavigationManager {
    var path: NavigationPath = .init()
    var selectedTab: TabDestination = .home

    func navigate(to_ destination: PushDestination) {
        path.append(destination)
    }

    func navigateToBack() {
        path.removeLast()
    }

    func navigateToRoot() {
        path.removeLast(path.count > 0 ? path.count : 0)
    }

    func changeSelectedTab(tab: TabDestination) {
        selectedTab = tab
    }

    public enum PushDestination: Codable, Hashable {
        case login
        case signUp
        case onboard(user: UserModel)
        case tabRoot
    }
}

enum TabDestination: String, Hashable, CaseIterable {
    case home
    case chat
    case profile

    var imageName: String {
        switch self {
        case .home:
            return "house"
        case .chat:
            return "brain.head.profile"
        case .profile:
            return "person"
        }
    }
}
