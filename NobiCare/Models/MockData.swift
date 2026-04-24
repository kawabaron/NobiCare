import Foundation

enum MockData {
    static let bodyAreas: [BodyArea] = [
        BodyArea(id: "neck", title: "首が重い", subtitle: "すっきりしたい", iconType: .neck, recommendedRoutineId: "neck-refresh"),
        BodyArea(id: "shoulder", title: "肩がこる", subtitle: "楽になりたい", iconType: .shoulder, recommendedRoutineId: "shoulder-release"),
        BodyArea(id: "waist", title: "腰がだるい", subtitle: "ラクにしたい", iconType: .waist, recommendedRoutineId: "waist-refresh"),
        BodyArea(id: "back", title: "背中が固い", subtitle: "ゆるめたい", iconType: .back, recommendedRoutineId: "night-stretch")
    ]

    static let routines: [Routine] = [
        Routine(
            id: "neck-refresh",
            title: "首すっきりストレッチ",
            description: "首まわりをやさしくほぐす",
            durationSeconds: 60,
            durationLabel: "1分",
            place: .chair,
            targetAreas: ["首"],
            kindnessLevel: 1,
            steps: [
                RoutineStep(id: "neck-front", title: "首前面ストレッチ", instruction: "息を吸って、ゆっくり伸ばしましょう", seconds: 20, targetArea: "首", poseType: .neckFront),
                RoutineStep(id: "shoulder-roll", title: "肩まわりストレッチ", instruction: "肩をゆっくり後ろに回します", seconds: 20, targetArea: "肩", poseType: .shoulder),
                RoutineStep(id: "back-soft", title: "背中の伸ばし", instruction: "背中をやさしく伸ばしましょう", seconds: 20, targetArea: "背中", poseType: .back)
            ]
        ),
        Routine(
            id: "shoulder-release",
            title: "肩ふわリリース",
            description: "肩まわりを軽く、呼吸も深く",
            durationSeconds: 60,
            durationLabel: "1分",
            place: .chair,
            targetAreas: ["肩"],
            kindnessLevel: 1,
            steps: [
                RoutineStep(id: "shoulder-soft", title: "肩まわりストレッチ", instruction: "力を抜いて、ゆっくり動かします", seconds: 20, targetArea: "肩", poseType: .shoulder),
                RoutineStep(id: "side-open", title: "体側ストレッチ", instruction: "脇腹までふわっと伸ばしましょう", seconds: 20, targetArea: "肩", poseType: .sideBend),
                RoutineStep(id: "neck-calm", title: "首のひと息", instruction: "首の力をほどいて、呼吸を整えます", seconds: 20, targetArea: "首", poseType: .neckFront)
            ]
        ),
        Routine(
            id: "waist-refresh",
            title: "腰リフレッシュ",
            description: "腰まわりをやさしくゆるめる",
            durationSeconds: 120,
            durationLabel: "2分",
            place: .chair,
            targetAreas: ["腰"],
            kindnessLevel: 2,
            steps: [
                RoutineStep(id: "waist-back", title: "背中の伸ばし", instruction: "腰から背中を長く伸ばします", seconds: 40, targetArea: "腰", poseType: .back),
                RoutineStep(id: "waist-side", title: "体側ストレッチ", instruction: "片側ずつ、無理なく伸ばしましょう", seconds: 40, targetArea: "腰", poseType: .sideBend),
                RoutineStep(id: "waist-reset", title: "肩まわりストレッチ", instruction: "最後は肩を軽く回して整えます", seconds: 40, targetArea: "肩", poseType: .shoulder)
            ]
        ),
        Routine(
            id: "night-stretch",
            title: "おやすみ前ストレッチ",
            description: "呼吸を深めて、リラックス",
            durationSeconds: 120,
            durationLabel: "2分",
            place: .bed,
            targetAreas: ["肩", "背中"],
            kindnessLevel: 1,
            steps: [
                RoutineStep(id: "night-shoulder", title: "肩まわりストレッチ", instruction: "今日の力みをそっとほどきます", seconds: 40, targetArea: "肩", poseType: .shoulder),
                RoutineStep(id: "night-back", title: "背中の伸ばし", instruction: "吐く息に合わせて、背中をゆるめます", seconds: 40, targetArea: "背中", poseType: .back),
                RoutineStep(id: "night-side", title: "体側ストレッチ", instruction: "眠りに向けて、呼吸を深くします", seconds: 40, targetArea: "背中", poseType: .sideBend)
            ]
        )
    ]

    static func routine(id: String) -> Routine {
        routines.first { $0.id == id } ?? routines[0]
    }
}
