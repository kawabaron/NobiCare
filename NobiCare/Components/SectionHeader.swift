import SwiftUI

struct SectionHeader: View {
    let title: String
    var subtitle: String?
    var color: Color = NCColors.charcoal

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(NCTypography.h2)
                .foregroundColor(color)
            if let subtitle {
                Text(subtitle)
                    .font(NCTypography.caption)
                    .foregroundColor(color.opacity(0.62))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
