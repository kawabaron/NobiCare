import SwiftUI

struct WeeklyDotsView: View {
    var achieved: [Bool] = [true, true, false, true, true, false, false]
    var accentIndex: Int = 5
    @State private var appeared = false
    private let days = ["月", "火", "水", "木", "金", "土", "日"]

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
                        .scaleEffect(appeared ? 1 : 0.2)
                        .opacity(appeared ? 1 : 0)
                        .animation(.spring(response: 0.38, dampingFraction: 0.78).delay(Double(index) * 0.045), value: appeared)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .onAppear { appeared = true }
    }

    private func color(for index: Int) -> Color {
        if index == accentIndex { return NCColors.mutedCoral }
        return achieved.indices.contains(index) && achieved[index] ? NCColors.deepSage : NCColors.border
    }
}
