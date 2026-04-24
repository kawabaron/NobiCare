import Foundation

struct BodyArea: Identifiable, Hashable {
    let id: String
    let title: String
    let subtitle: String
    let iconType: BodyAreaIconType
    let recommendedRoutineId: String
}

enum BodyAreaIconType: String, Hashable {
    case neck
    case shoulder
    case waist
    case back
}
