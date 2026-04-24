import SwiftUI

enum NCColors {
    static let ivory = Color(hex: 0xFBFAF6)
    static let cream = Color(hex: 0xF5F3E7)
    static let sage = Color(hex: 0xA7B699)
    static let deepSage = Color(hex: 0x6F836C)
    static let mutedCoral = Color(hex: 0xF4A093)
    static let gentleRose = Color(hex: 0xF7C9C2)
    static let charcoal = Color(hex: 0x2F3336)
    static let softText = Color(hex: 0x6F716A)
    static let border = Color(hex: 0xD8D2C4)
    static let nightBackground = Color(hex: 0x1F2B32)
    static let nightCard = Color(hex: 0x2B3942)
    static let nightText = Color(hex: 0xF7F1E8)
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}
