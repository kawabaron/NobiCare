import SwiftUI

enum NCTypography {
    static let h1 = Font.system(.title, design: .rounded, weight: .bold)
    static let h2 = Font.system(.title3, design: .rounded, weight: .semibold)
    static let h3 = Font.system(.body, design: .rounded, weight: .semibold)
    static let body = Font.system(.body, design: .rounded, weight: .regular)
    static let caption = Font.system(.caption, design: .rounded, weight: .regular)
    static let timer = Font.system(size: 72, weight: .light, design: .rounded)
}
