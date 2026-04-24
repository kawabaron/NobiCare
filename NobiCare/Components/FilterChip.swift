import SwiftUI

struct FilterChip: View {
    let label: String
    var iconName: String?
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if let iconName {
                    Image(systemName: iconName)
                        .font(.system(size: 12, weight: .semibold))
                }
                Text(label)
                    .font(NCTypography.caption.weight(.semibold))
            }
            .foregroundColor(isSelected ? .white : NCColors.charcoal)
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(isSelected ? NCColors.deepSage : NCColors.cream)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(isSelected ? NCColors.deepSage : NCColors.border, lineWidth: 1))
            .scaleEffect(isSelected ? 1.03 : 1)
            .animation(.spring(response: 0.35, dampingFraction: 0.82), value: isSelected)
        }
        .buttonStyle(PressableButtonStyle())
    }
}
