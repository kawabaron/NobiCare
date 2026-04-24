import SwiftUI

struct MainTabView: View {
    @StateObject private var navigation = AppNavigationViewModel()

    var body: some View {
        TabView(selection: $navigation.selectedTab) {
            NavigationStack(path: $navigation.homePath) {
                HomeView()
                    .navigationDestination(for: AppRoute.self, destination: destination)
            }
            .tabItem { Label("ホーム", systemImage: "house.fill") }
            .tag(AppTab.home)

            NavigationStack(path: $navigation.routinePath) {
                RoutineSelectionView()
                    .navigationDestination(for: AppRoute.self, destination: destination)
            }
            .tabItem { Label("ルーティン", systemImage: "timer") }
            .tag(AppTab.routines)

            NavigationStack(path: $navigation.progressPath) {
                ProgressView()
                    .navigationDestination(for: AppRoute.self, destination: destination)
            }
            .tabItem { Label("記録", systemImage: "chart.bar.fill") }
            .tag(AppTab.progress)

            NavigationStack(path: $navigation.settingsPath) {
                NightModeView()
                    .navigationDestination(for: AppRoute.self, destination: destination)
            }
            .tabItem { Label("設定", systemImage: "gearshape") }
            .tag(AppTab.settings)
        }
        .tint(NCColors.deepSage)
        .environmentObject(navigation)
    }

    @ViewBuilder
    private func destination(_ route: AppRoute) -> some View {
        switch route {
        case .routineSelection:
            RoutineSelectionView()
        case .execution(let routineId):
            ExecutionView(routine: MockData.routine(id: routineId))
        case .completion(let routineId):
            CompletionView(routine: MockData.routine(id: routineId))
        case .nightMode:
            NightModeView()
        }
    }
}
