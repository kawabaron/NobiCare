import Foundation
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

struct CareLogEntry: Identifiable, Codable, Hashable {
    let id: UUID
    let routineId: String
    let routineTitle: String
    let targetAreas: [String]
    let durationSeconds: Int
    let completedAt: Date
}

final class CareLogStore: ObservableObject {
    @Published private(set) var entries: [CareLogEntry] = [] {
        didSet { save() }
    }

    private let userDefaults: UserDefaults
    private let calendar: Calendar
    private let storageKey = "nobicare.careLog.entries"

    init(userDefaults: UserDefaults = .standard, calendar: Calendar = .current) {
        self.userDefaults = userDefaults
        self.calendar = calendar
        load()
    }

    func recordCompletion(of routine: Routine) {
        let entry = CareLogEntry(
            id: UUID(),
            routineId: routine.id,
            routineTitle: routine.title,
            targetAreas: routine.targetAreas,
            durationSeconds: routine.durationSeconds,
            completedAt: Date()
        )
        entries.insert(entry, at: 0)
    }

    var weeklyAchievements: [Bool] {
        let weekStart = startOfCurrentWeek()
        return (0..<7).map { dayOffset in
            guard let day = calendar.date(byAdding: .day, value: dayOffset, to: weekStart) else {
                return false
            }
            return entries.contains { calendar.isDate($0.completedAt, inSameDayAs: day) }
        }
    }

    var currentWeekdayIndex: Int {
        let weekday = calendar.component(.weekday, from: Date())
        return (weekday + 5) % 7
    }

    var totalDaysThisWeek: Int {
        weeklyAchievements.filter { $0 }.count
    }

    var totalMinutesThisWeek: Int {
        let seconds = entriesThisWeek.reduce(0) { $0 + $1.durationSeconds }
        return Int(ceil(Double(seconds) / 60.0))
    }

    var recentEntries: [CareLogEntry] {
        Array(entries.prefix(5))
    }

    var areaStats: [(area: String, count: Int)] {
        let counts = entries.reduce(into: [String: Int]()) { partialResult, entry in
            entry.targetAreas.forEach { partialResult[$0, default: 0] += 1 }
        }
        return counts
            .sorted { lhs, rhs in
                if lhs.value == rhs.value { return lhs.key < rhs.key }
                return lhs.value > rhs.value
            }
            .map { (area: $0.key, count: $0.value) }
    }

    func formattedCompletedAt(_ date: Date) -> String {
        if calendar.isDateInToday(date) {
            return "今日 " + Self.timeFormatter.string(from: date)
        }
        if calendar.isDateInYesterday(date) {
            return "昨日 " + Self.timeFormatter.string(from: date)
        }
        return Self.dateTimeFormatter.string(from: date)
    }

    private var entriesThisWeek: [CareLogEntry] {
        let weekStart = startOfCurrentWeek()
        guard let nextWeek = calendar.date(byAdding: .day, value: 7, to: weekStart) else {
            return []
        }
        return entries.filter { weekStart <= $0.completedAt && $0.completedAt < nextWeek }
    }

    private func startOfCurrentWeek() -> Date {
        let now = Date()
        let weekday = calendar.component(.weekday, from: now)
        let daysFromMonday = (weekday + 5) % 7
        let startOfToday = calendar.startOfDay(for: now)
        return calendar.date(byAdding: .day, value: -daysFromMonday, to: startOfToday) ?? startOfToday
    }

    private func load() {
        guard let data = userDefaults.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([CareLogEntry].self, from: data) else {
            entries = []
            return
        }
        entries = decoded.sorted { $0.completedAt > $1.completedAt }
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(entries) else { return }
        userDefaults.set(data, forKey: storageKey)
    }

    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "HH:mm"
        return formatter
    }()

    private static let dateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "M/d HH:mm"
        return formatter
    }()
}
