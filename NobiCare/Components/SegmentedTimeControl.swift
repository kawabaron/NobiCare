import SwiftUI

struct SegmentedTimeControl: View {
    @Binding var selectedSeconds: Int
    var onSelectionChanged: () -> Void = {}
    @Namespace private var namespace
    private let options = [60, 120, 180]

    var body: some View {
        HStack(spacing: 4) {
            ForEach(options, id: \.self) { seconds in
                Button {
                    selectedSeconds = seconds
                    onSelectionChanged()
                } label: {
                    Text("\(seconds / 60)分")
                        .font(NCTypography.caption.weight(.semibold))
                        .foregroundColor(selectedSeconds == seconds ? .white : NCColors.charcoal)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background {
                            if selectedSeconds == seconds {
                                Capsule()
                                    .fill(NCColors.deepSage)
                                    .matchedGeometryEffect(id: "time-background", in: namespace)
                            }
                        }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(4)
        .background(NCColors.cream)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(NCColors.border, lineWidth: 1))
        .animation(.spring(response: 0.36, dampingFraction: 0.86), value: selectedSeconds)
    }
}
