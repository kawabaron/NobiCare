import Foundation

struct Routine: Identifiable, Hashable {
    let id: String
    let title: String
    let description: String
    let durationSeconds: Int
    let durationLabel: String
    let place: Place
    let targetAreas: [String]
    let kindnessLevel: Int
    let steps: [RoutineStep]

    enum Place: String, CaseIterable, Hashable {
        case chair
        case floor
        case bed

        var label: String {
            switch self {
            case .chair: return "椅子"
            case .floor: return "床"
            case .bed: return "ベッド"
            }
        }

        var iconName: String {
            switch self {
            case .chair: return "chair"
            case .floor: return "figure.cooldown"
            case .bed: return "bed.double"
            }
        }
    }
}
