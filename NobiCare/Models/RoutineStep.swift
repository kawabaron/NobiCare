import Foundation

struct RoutineStep: Identifiable, Hashable {
    let id: String
    let title: String
    let instruction: String
    let seconds: Int
    let targetArea: String
    let poseType: StretchPoseType
}

enum StretchPoseType: String, Hashable {
    case neckFront
    case shoulder
    case back
    case sideBend
}
