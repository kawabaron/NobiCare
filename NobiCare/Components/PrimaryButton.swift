import SwiftUI

struct PrimaryButton: View {
    let title: String
    var iconName: String?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Text(title)
                    .font(NCTypography.h3)
                if let iconName {
                    Image(systemName: iconName)
                        .font(.system(size: 15, weight: .semibold))
                }
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(NCColors.deepSage)
            .clipShape(RoundedRectangle(cornerRadius: NCSpacing.buttonRadius, style: .continuous))
            .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 7)
        }
        .buttonStyle(PressableButtonStyle())
        .accessibilityLabel(title)
    }
}
