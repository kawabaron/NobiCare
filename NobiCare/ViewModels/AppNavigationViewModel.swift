import SwiftUI

enum AppTab: Hashable {
    case home
    case routines
    case progress
    case settings
}

enum AppRoute: Hashable {
    case routineSelection
    case execution(String)
    case completion(String)
    case nightMode
}

final class AppNavigationViewModel: ObservableObject {
    @Published var selectedTab: AppTab = .home
    @Published var homePath = NavigationPath()
    @Published var routinePath = NavigationPath()
    @Published var progressPath = NavigationPath()
    @Published var settingsPath = NavigationPath()

    func push(_ route: AppRoute) {
        switch selectedTab {
        case .home:
            homePath.append(route)
        case .routines:
            routinePath.append(route)
        case .progress:
            progressPath.append(route)
        case .settings:
            settingsPath.append(route)
        }
    }

    func returnHome() {
        selectedTab = .home
        homePath = NavigationPath()
        routinePath = NavigationPath()
        progressPath = NavigationPath()
        settingsPath = NavigationPath()
    }
}
