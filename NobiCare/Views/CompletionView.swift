import SwiftUI

struct CompletionView: View {
    @EnvironmentObject private var navigation: AppNavigationViewModel
    @EnvironmentObject private var careLogStore: CareLogStore
    let routine: Routine
    @State private var appeared = false
    @State private var floatConfetti = false
    @State private var didRecordCompletion = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack {
            NCColors.ivory.ignoresSafeArea()
            if !reduceMotion {
                confetti
            }

            VStack(spacing: 22) {
                Spacer()

                MascotView(mood: .happy, size: 132)
                    .scaleEffect(appeared ? 1 : 0.88)
                    .opacity(appeared ? 1 : 0)
                    .animation(.spring(response: 0.48, dampingFraction: 0.82), value: appeared)

                VStack(spacing: 9) {
                    Text("今日も、少し整いました")
                        .font(NCTypography.h1)
                        .foregroundColor(NCColors.charcoal)
                        .multilineTextAlignment(.center)
                    Text("自分のペースで、えらいです。")
                        .font(NCTypography.body)
                        .foregroundColor(NCColors.softText)
                }
                .appear(appeared, delay: 0.1)

                SoftCard {
                    VStack(alignment: .leading, spacing: 16) {
                        SectionHeader(title: "今週のふりかえり")
                        WeeklyDotsView(achieved: careLogStore.weeklyAchievements, accentIndex: careLogStore.currentWeekdayIndex)
                        HStack {
                            metric(title: "今週の合計", value: "\(careLogStore.totalDaysThisWeek)日")
                            Divider().frame(height: 34)
                            metric(title: "合計時間", value: "\(careLogStore.totalMinutesThisWeek)分")
                        }
                        Text("小さな積み重ねが、大きな変化をつくります。")
                            .font(NCTypography.caption)
                            .foregroundColor(NCColors.softText)
                    }
                }
                .appear(appeared, delay: 0.18)

                PrimaryButton(title: "ホームに戻る", iconName: "house.fill") {
                    navigation.returnHome()
                }
                .appear(appeared, delay: 0.28)

                Spacer()
            }
            .padding(.horizontal, NCSpacing.screen)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            recordCompletionIfNeeded()
            appeared = true
            guard !reduceMotion else { return }
            withAnimation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true)) {
                floatConfetti = true
            }
        }
    }

    private var confetti: some View {
        ZStack {
            ForEach(0..<12, id: \.self) { index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(index.isMultiple(of: 3) ? NCColors.mutedCoral : (index.isMultiple(of: 2) ? NCColors.sage : NCColors.gentleRose))
                    .frame(width: index.isMultiple(of: 2) ? 5 : 4, height: index.isMultiple(of: 2) ? 10 : 6)
                    .rotationEffect(.degrees(floatConfetti ? Double(index * 18) : Double(index * 7)))
                    .offset(x: CGFloat((index % 4) * 58 - 90), y: CGFloat((index / 4) * 72 - 230) + (floatConfetti ? 10 : -8))
                    .opacity(appeared ? 0.72 : 0)
                    .animation(.easeInOut(duration: 1.8).delay(Double(index) * 0.04), value: appeared)
            }
        }
    }

    private func metric(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(NCTypography.caption)
                .foregroundColor(NCColors.softText)
            Text(value)
                .font(NCTypography.h2)
                .foregroundColor(NCColors.charcoal)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func recordCompletionIfNeeded() {
        guard !didRecordCompletion else { return }
        careLogStore.recordCompletion(of: routine)
        didRecordCompletion = true
    }
}
