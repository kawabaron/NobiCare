import SwiftUI

struct SoftCard<Content: View>: View {
    var background: Color = NCColors.cream
    var borderColor: Color = NCColors.border.opacity(0.72)
    var radius: CGFloat = NCSpacing.cardRadius
    @ViewBuilder let content: Content

    var body: some View {
        content
            .padding(NCSpacing.lg)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .stroke(borderColor, lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.06), radius: 12, x: 0, y: 6)
    }
}
