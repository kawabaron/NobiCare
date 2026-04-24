import SwiftUI

struct WeeklyDotsView: View {
    var achieved: [Bool]
    var accentIndex: Int
    @State private var appeared = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    private let days = ["月", "火", "水", "木", "金", "土", "日"]

    init(achieved: [Bool] = [false, false, false, false, false, false, false], accentIndex: Int = 0) {
        self.achieved = achieved
        self.accentIndex = accentIndex
    }

    var body: some View {
        HStack(spacing: 12) {
            ForEach(days.indices, id: \.self) { index in
                VStack(spacing: 8) {
                    Text(days[index])
                        .font(NCTypography.caption)
                        .foregroundColor(NCColors.softText)
                    Circle()
                        .fill(color(for: index))
                        .frame(width: 12, height: 12)
                        .scaleEffect(appeared || reduceMotion ? 1 : 0.2)
                        .opacity(appeared || reduceMotion ? 1 : 0)
                        .animation(reduceMotion ? nil : .spring(response: 0.38, dampingFraction: 0.78).delay(Double(index) * 0.045), value: appeared)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .onAppear { appeared = true }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilitySummary)
    }

    private func color(for index: Int) -> Color {
        if index == accentIndex { return NCColors.mutedCoral }
        return achieved.indices.contains(index) && achieved[index] ? NCColors.deepSage : NCColors.border
    }

    private var accessibilitySummary: String {
        let achievedDays = days.indices.compactMap { index in
            achieved.indices.contains(index) && achieved[index] ? days[index] : nil
        }
        if achievedDays.isEmpty {
            return "今週の記録はまだありません"
        }
        return "今週の記録、" + achievedDays.joined(separator: "、") + "に実施済み"
    }
}
