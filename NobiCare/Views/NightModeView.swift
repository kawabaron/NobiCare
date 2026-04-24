import SwiftUI

struct NightModeView: View {
    @EnvironmentObject private var navigation: AppNavigationViewModel
    @State private var reminderOn = true
    @State private var appeared = false

    var body: some View {
        ZStack {
            NCColors.nightBackground.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {
                    header
                        .appear(appeared, delay: 0)

                    nightRoutineCard
                        .appear(appeared, delay: 0.1)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("クイックアクション")
                            .font(NCTypography.h2)
                            .foregroundColor(NCColors.nightText)
                        HStack(spacing: 10) {
                            quickAction(title: "肩をゆるめる", duration: "1分", icon: "figure.arms.open", routineId: "shoulder-release")
                            quickAction(title: "腰をやさしく", duration: "1分", icon: "figure.cooldown", routineId: "waist-refresh")
                            quickAction(title: "呼吸を整える", duration: "1分", icon: "wind", routineId: "night-stretch")
                        }
                    }
                    .appear(appeared, delay: 0.18)

                    reminderCard
                        .appear(appeared, delay: 0.28)

                    SettingsPlaceholderView()
                        .appear(appeared, delay: 0.36)
                }
                .padding(.horizontal, NCSpacing.screen)
                .padding(.top, 20)
                .padding(.bottom, 30)
            }
        }
        .navigationBarHidden(true)
        .onAppear { appeared = true }
    }

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                Text("おやすみなさい")
                    .font(NCTypography.h1)
                    .foregroundColor(NCColors.nightText)
                Text("1日の疲れを、やさしくリセット。")
                    .font(NCTypography.body)
                    .foregroundColor(NCColors.nightText.opacity(0.72))
            }
            Spacer()
            MascotView(mood: .sleepy, size: 82)
        }
    }

    private var nightRoutineCard: some View {
        Button {
            navigation.push(.execution("night-stretch"))
        } label: {
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 9) {
                    Text("おすすめの夜ルーティン")
                        .font(NCTypography.caption.weight(.semibold))
                        .foregroundColor(NCColors.gentleRose)
                    Text("おやすみ前ストレッチ")
                        .font(NCTypography.h2)
                        .foregroundColor(NCColors.nightText)
                    Text("呼吸を深めて、リラックス")
                        .font(NCTypography.body)
                        .foregroundColor(NCColors.nightText.opacity(0.72))
                    Text("2分 / ベッド")
                        .font(NCTypography.caption.weight(.semibold))
                        .foregroundColor(NCColors.nightText)
                        .padding(.horizontal, 11)
                        .padding(.vertical, 7)
                        .background(NCColors.sage.opacity(0.22))
                        .clipShape(Capsule())
                }
                Spacer()
                Image(systemName: "moon.stars.fill")
                    .font(.system(size: 32))
                    .foregroundColor(NCColors.gentleRose)
            }
            .padding(20)
            .background(NCColors.nightCard)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 24, style: .continuous).stroke(NCColors.sage.opacity(0.18), lineWidth: 1))
        }
        .buttonStyle(PressableButtonStyle(pressedScale: 0.98))
    }

    private func quickAction(title: String, duration: String, icon: String, routineId: String) -> some View {
        Button {
            navigation.push(.execution(routineId))
        } label: {
            VStack(spacing: 9) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                Text(title)
                    .font(NCTypography.caption.weight(.semibold))
                    .multilineTextAlignment(.center)
                Text(duration)
                    .font(NCTypography.caption)
                    .opacity(0.75)
            }
            .foregroundColor(NCColors.nightText)
            .frame(maxWidth: .infinity)
            .frame(height: 102)
            .background(NCColors.nightCard.opacity(0.82))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(NCColors.sage.opacity(0.18), lineWidth: 1))
        }
        .buttonStyle(PressableButtonStyle(pressedScale: 0.96))
    }

    private var reminderCard: some View {
        HStack(spacing: 14) {
            Image(systemName: "bell.badge")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(NCColors.gentleRose)
                .frame(width: 44, height: 44)
                .background(NCColors.nightText.opacity(0.08))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text("リマインダー設定")
                    .font(NCTypography.h3)
                    .foregroundColor(NCColors.nightText)
                Text("毎日 07:30 にお知らせ")
                    .font(NCTypography.caption)
                    .foregroundColor(NCColors.nightText.opacity(0.66))
            }
            Spacer()
            Toggle("", isOn: $reminderOn)
                .labelsHidden()
                .tint(NCColors.sage)
        }
        .padding(18)
        .background(NCColors.nightCard)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 22, style: .continuous).stroke(NCColors.sage.opacity(0.18), lineWidth: 1))
    }
}
