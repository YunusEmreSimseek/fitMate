//
//  TabRootView.swift
//  fitMate
//
//  Created by Emre Simsek on 29.04.2025.
//

import SwiftUI

struct TabRootView: View {
    @Environment(NavigationManager.self) private var navigationManager
    @Namespace private var animation
    var body: some View {
        @Bindable var navigationManager = navigationManager
        VStack(spacing: .zero) {
            ZStack(alignment: .bottom) {
                switch navigationManager.selectedTab {
                case .home:
                    NavigationView {
                        HomeView()
                    }
                case .chat:
                    NavigationView {
                        ChatView()
                    }
                case .profile:
                    NavigationView {
                        ProfileView()
                    }
                case .track:
                    NavigationView {
                        TrackingView()
                    }
                }
            }
            CustomTabBar(selectedTab: $navigationManager.selectedTab, animation: animation)
        }
        .ignoresSafeArea(edges: .bottom)
        .background(.cBackground)
    }
}

#Preview {
    TabRootView()
        .background(.cBackground)
        .environment(AppContainer.shared.userSessionManager)
        .environment(AppContainer.shared.navigationManager)
        .environment(AppContainer.shared.healthKitManager)
        .environment(AppContainer.shared.goalManager)
}

private struct CustomTabBar: View {
    @Binding var selectedTab: TabDestination
    var animation: Namespace.ID

    var body: some View {
        HStack {
            ForEach(TabDestination.allCases, id: \.self) { tab in
                tabButton(tab)
            }
        }
        .vPadding(.medium3)
        .hPadding(.medium3)
        .background(
            Color(.cGray)
                .clipShape(.rect(cornerRadius: .normal))
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
        )
    }

    private func tabButton(_ tab: TabDestination) -> some View {
        Button {
            withAnimation(.spring()) {
                selectedTab = tab
            }
        } label: {
            VStack(spacing: .low3) {
                ZStack {
                    if selectedTab == tab {
                        Circle()
                            .fill(.cBlue)
                            .matchedGeometryEffect(id: "background", in: animation)
                            .frame(width: .high2, height: .high2)
                            .scaleEffect(selectedTab == tab ? 1.2 : 1.0)
                    }

                    Image(systemName: tab.imageName)
                        .imageScale(.large)
                        .foregroundColor(selectedTab == tab ? .primary : .gray)
                        .frame(height: .dynamicHeight(height: 0.025))
                }
                Text(tab.rawValue.capitalized)
                    .font(.footnote)
                    .minimumScaleFactor(0.7)
                    .foregroundColor(selectedTab == tab ? .cBlue : .secondary)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
