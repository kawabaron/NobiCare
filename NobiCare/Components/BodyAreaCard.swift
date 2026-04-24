import SwiftUI

struct BodyAreaCard: View {
    let area: BodyArea
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                icon
                    .frame(width: 46, height: 46)
                    .background(NCColors.ivory)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                VStack(alignment: .leading, spacing: 3) {
                    Text(area.title)
                        .font(NCTypography.h3)
                        .foregroundColor(NCColors.charcoal)
                    Text(area.subtitle)
                        .font(NCTypography.caption)
                        .foregroundColor(NCColors.softText)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(isSelected ? NCColors.sage.opacity(0.12) : NCColors.cream)
            .clipShape(RoundedRectangle(cornerRadius: NCSpacing.smallRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: NCSpacing.smallRadius, style: .continuous)
                    .stroke(isSelected ? NCColors.deepSage : NCColors.border.opacity(0.8), lineWidth: isSelected ? 1.5 : 1)
            )
            .shadow(color: .black.opacity(0.04), radius: 9, x: 0, y: 5)
            .scaleEffect(isSelected ? 1.025 : 1)
            .animation(.spring(response: 0.35, dampingFraction: 0.82), value: isSelected)
        }
        .buttonStyle(PressableButtonStyle(pressedScale: 0.97))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(area.title)、\(area.subtitle)")
        .accessibilityValue(isSelected ? "選択中" : "未選択")
        .accessibilityHint("おすすめルーティンを切り替えます")
    }

    private var icon: some View {
        ZStack {
            Circle()
                .fill(NCColors.gentleRose.opacity(0.38))
                .frame(width: 28, height: 28)
                .offset(iconHighlightOffset)
            Image(systemName: iconName)
                .font(.system(size: 22, weight: .regular))
                .foregroundColor(NCColors.deepSage)
        }
    }

    private var iconName: String {
        switch area.iconType {
        case .neck: return "person.crop.circle"
        case .shoulder: return "figure.arms.open"
        case .waist: return "figure.cooldown"
        case .back: return "figure.flexibility"
        }
    }

    private var iconHighlightOffset: CGSize {
        switch area.iconType {
        case .neck: return CGSize(width: 0, height: -8)
        case .shoulder: return CGSize(width: 9, height: -1)
        case .waist: return CGSize(width: 0, height: 8)
        case .back: return CGSize(width: -8, height: 0)
        }
    }
}
