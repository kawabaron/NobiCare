import SwiftUI

struct ExecutionView: View {
    @EnvironmentObject private var navigation: AppNavigationViewModel
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: ExecutionViewModel
    @State private var secondsPulse = false
    @State private var appeared = false

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(routine: Routine) {
        _viewModel = StateObject(wrappedValue: ExecutionViewModel(routine: routine))
    }

    var body: some View {
        ZStack {
            NCColors.ivory.ignoresSafeArea()
            VStack(spacing: 18) {
                topBar
                    .padding(.horizontal, NCSpacing.screen)
                    .padding(.top, 6)

                VStack(spacing: 8) {
                    Text(viewModel.currentStep.title)
                        .font(NCTypography.h2)
                        .foregroundColor(NCColors.charcoal)
                    Text(viewModel.currentStep.instruction)
                        .font(NCTypography.body)
                        .foregroundColor(NCColors.softText)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 28)
                .appear(appeared, delay: 0.04)

                Spacer(minLength: 4)

                CircularProgressTimerView(progress: viewModel.progress, pose: viewModel.currentStep.poseType)
                    .appear(appeared, delay: 0.12)

                VStack(spacing: 2) {
                    Text("\(viewModel.remainingSeconds)")
                        .font(NCTypography.timer)
                        .foregroundColor(NCColors.charcoal)
                        .scaleEffect(secondsPulse ? 1.04 : 1)
                        .animation(.spring(response: 0.28, dampingFraction: 0.72), value: secondsPulse)
                    Text("秒")
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                        .foregroundColor(NCColors.softText)
                    Text("残り時間")
                        .font(NCTypography.caption)
                        .foregroundColor(NCColors.softText.opacity(0.85))
                        .padding(.top, 4)
                }
                .appear(appeared, delay: 0.18)

                stepDots
                    .appear(appeared, delay: 0.22)

                Spacer(minLength: 6)

                controls
                    .padding(.horizontal, NCSpacing.screen)
                    .padding(.bottom, 12)
                    .appear(appeared, delay: 0.28)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .onAppear { appeared = true }
        .onReceive(timer) { _ in
            if viewModel.tick() {
                navigation.push(.completion(viewModel.routine.id))
            }
            secondsPulse.toggle()
        }
    }

    private var topBar: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(NCColors.charcoal)
                    .frame(width: 44, height: 44)
                    .background(NCColors.cream)
                    .clipShape(Circle())
            }
            .buttonStyle(PressableButtonStyle())

            Spacer()

            Text(viewModel.stepProgressText)
                .font(NCTypography.caption.weight(.semibold))
                .foregroundColor(NCColors.softText)

            Spacer()

            Button {} label: {
                Image(systemName: "speaker.wave.2")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(NCColors.charcoal)
                    .frame(width: 44, height: 44)
                    .background(NCColors.cream)
                    .clipShape(Circle())
            }
            .buttonStyle(PressableButtonStyle())
        }
    }

    private var stepDots: some View {
        HStack(spacing: 8) {
            ForEach(viewModel.routine.steps.indices, id: \.self) { index in
                Circle()
                    .fill(index == viewModel.currentStepIndex ? NCColors.mutedCoral : (index < viewModel.currentStepIndex ? NCColors.deepSage : NCColors.border))
                    .frame(width: index == viewModel.currentStepIndex ? 9 : 7, height: index == viewModel.currentStepIndex ? 9 : 7)
                    .animation(.spring(response: 0.35, dampingFraction: 0.8), value: viewModel.currentStepIndex)
            }
        }
    }

    private var controls: some View {
        HStack(spacing: 12) {
            controlButton(title: "前へ", icon: "backward.fill") {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.82)) {
                    viewModel.previous()
                }
            }

            Button {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.82)) {
                    viewModel.togglePause()
                }
            } label: {
                VStack(spacing: 6) {
                    Image(systemName: viewModel.isPaused ? "play.fill" : "pause.fill")
                        .font(.system(size: 22, weight: .medium))
                    Text(viewModel.isPaused ? "再開" : "一時停止")
                        .font(NCTypography.caption)
                }
                .foregroundColor(NCColors.deepSage)
                .frame(width: 86, height: 74)
                .background(Color.white.opacity(0.72))
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 24, style: .continuous).stroke(NCColors.border, lineWidth: 1))
            }
            .buttonStyle(PressableButtonStyle())

            controlButton(title: "次の動きへ", icon: "forward.fill") {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.82)) {
                    if viewModel.advance() {
                        navigation.push(.completion(viewModel.routine.id))
                    }
                }
            }
        }
    }

    private func controlButton(title: String, icon: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 17, weight: .medium))
                Text(title)
                    .font(NCTypography.caption)
            }
            .foregroundColor(NCColors.charcoal)
            .frame(maxWidth: .infinity)
            .frame(height: 64)
            .background(NCColors.cream)
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 22, style: .continuous).stroke(NCColors.border.opacity(0.8), lineWidth: 1))
        }
        .buttonStyle(PressableButtonStyle())
    }
}
