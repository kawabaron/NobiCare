import SwiftUI

struct CircularProgressTimerView: View {
    let progress: Double
    let pose: StretchPoseType
    @State private var breathing = false

    var body: some View {
        ZStack {
            Circle()
                .stroke(NCColors.sage.opacity(0.22), lineWidth: 10)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    NCColors.deepSage,
                    style: StrokeStyle(lineWidth: 10, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 1), value: progress)

            Circle()
                .fill(Color.white.opacity(0.5))
                .padding(18)

            StretchFigureView(pose: pose)
                .frame(width: 190, height: 190)
                .scaleEffect(breathing ? 1.015 : 1)
                .animation(.easeInOut(duration: 2.4).repeatForever(autoreverses: true), value: breathing)
        }
        .frame(width: 276, height: 276)
        .onAppear { breathing = true }
    }
}
