import SwiftUI

struct RoutineCard: View {
    let routine: Routine
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(NCColors.ivory)
                    StretchFigureView(pose: routine.steps.first?.poseType ?? .neckFront)
                        .padding(7)
                }
                .frame(width: 72, height: 72)

                VStack(alignment: .leading, spacing: 7) {
                    Text(routine.title)
                        .font(NCTypography.h3)
                        .foregroundColor(NCColors.charcoal)
                    Text(routine.description)
                        .font(NCTypography.caption)
                        .foregroundColor(NCColors.softText)
                        .lineLimit(1)
                    HStack(spacing: 7) {
                        miniPill(routine.durationLabel)
                        miniPill(routine.place.label)
                    }
                }

                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(NCColors.deepSage)
            }
            .padding(14)
            .background(NCColors.cream)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(NCColors.border.opacity(0.82), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 6)
        }
        .buttonStyle(PressableButtonStyle(pressedScale: 0.98))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(routine.title)、\(routine.description)、\(routine.durationLabel)、\(routine.place.label)")
        .accessibilityHint("ルーティンを開始します")
    }

    private func miniPill(_ text: String) -> some View {
        Text(text)
            .font(NCTypography.caption)
            .foregroundColor(NCColors.deepSage)
            .padding(.horizontal, 9)
            .padding(.vertical, 4)
            .background(NCColors.sage.opacity(0.16))
            .clipShape(Capsule())
    }
}
