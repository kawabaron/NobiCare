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
        ),
        Routine(
            id: "desk-reset",
            title: "デスクワークリセット",
            description: "首・肩・背中をまとめてゆるめる",
            durationSeconds: 180,
            durationLabel: "3分",
            place: .chair,
            targetAreas: ["首", "肩", "背中"],
            kindnessLevel: 2,
            steps: [
                RoutineStep(id: "desk-neck", title: "首の前側をゆるめる", instruction: "あごを少し上げて、息を止めずに伸ばします", seconds: 60, targetArea: "首", poseType: .neckFront),
                RoutineStep(id: "desk-shoulder", title: "肩を後ろに回す", instruction: "肩甲骨を寄せるように、ゆっくり回します", seconds: 60, targetArea: "肩", poseType: .shoulder),
                RoutineStep(id: "desk-back", title: "背中を長く伸ばす", instruction: "椅子に座ったまま、背中をふわっと伸ばします", seconds: 60, targetArea: "背中", poseType: .back)
            ]
        ),
        Routine(
            id: "floor-waist-care",
            title: "床で腰ゆるケア",
            description: "腰まわりをゆっくり休ませる",
            durationSeconds: 180,
            durationLabel: "3分",
            place: .floor,
            targetAreas: ["腰", "背中"],
            kindnessLevel: 2,
            steps: [
                RoutineStep(id: "floor-back", title: "背中を丸めて伸ばす", instruction: "吐く息に合わせて、腰から背中をゆるめます", seconds: 60, targetArea: "腰", poseType: .back),
                RoutineStep(id: "floor-side", title: "体側をゆっくり伸ばす", instruction: "片側ずつ、気持ちいい範囲で伸ばします", seconds: 60, targetArea: "腰", poseType: .sideBend),
                RoutineStep(id: "floor-reset", title: "肩の力を抜く", instruction: "最後に肩を軽く回して、呼吸を整えます", seconds: 60, targetArea: "肩", poseType: .shoulder)
            ]
        )
    ]

    static func routine(id: String) -> Routine {
        routines.first { $0.id == id } ?? routines[0]
    }
}
