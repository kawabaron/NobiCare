import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var navigation: AppNavigationViewModel
    @AppStorage("bedtimeReminderEnabled") private var reminderOn = true
    @AppStorage("voiceGuideEnabled") private var voiceGuideEnabled = true
    @State private var appeared = false

    var body: some View {
        ZStack {
            NCColors.ivory.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {
                    SectionHeader(title: "設定", subtitle: "通知・音・夜のケアを調整")
                        .appear(appeared, delay: 0)

                    nightModeEntry
                        .appear(appeared, delay: 0.08)

                    settingsCard
                        .appear(appeared, delay: 0.16)

                    supportCard
                        .appear(appeared, delay: 0.24)
                }
                .padding(.horizontal, NCSpacing.screen)
                .padding(.top, 20)
                .padding(.bottom, 28)
            }
        }
        .navigationBarHidden(true)
        .onAppear { appeared = true }
    }

    private var nightModeEntry: some View {
        Button {
            navigation.push(.nightMode)
        } label: {
            HStack(spacing: 16) {
                Image(systemName: "moon.stars.fill")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(NCColors.gentleRose)
                    .frame(width: 52, height: 52)
                    .background(NCColors.nightBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                VStack(alignment: .leading, spacing: 5) {
                    Text("おやすみ前モード")
                        .font(NCTypography.h3)
                        .foregroundColor(NCColors.charcoal)
                    Text("寝る前向けの静かなルーティンを開く")
                        .font(NCTypography.caption)
                        .foregroundColor(NCColors.softText)
                }

                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(NCColors.deepSage)
            }
            .padding(18)
            .background(NCColors.cream)
            .clipShape(RoundedRectangle(cornerRadius: NCSpacing.cardRadius, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: NCSpacing.cardRadius, style: .continuous).stroke(NCColors.border.opacity(0.72), lineWidth: 1))
            .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 6)
        }
        .buttonStyle(PressableButtonStyle(pressedScale: 0.98))
    }

    private var settingsCard: some View {
        SoftCard {
            VStack(spacing: 16) {
                settingToggle(
                    title: "リマインダー",
                    subtitle: "毎日 07:30 にお知らせ",
                    icon: "bell.badge",
                    isOn: $reminderOn
                )
                Divider()
                settingToggle(
                    title: "音声ガイド",
                    subtitle: "実行画面のスピーカーボタンと連動",
                    icon: voiceGuideEnabled ? "speaker.wave.2" : "speaker.slash",
                    isOn: $voiceGuideEnabled
                )
            }
        }
    }

    private var supportCard: some View {
        SoftCard {
            VStack(alignment: .leading, spacing: 8) {
                Text("セルフケアの注意")
                    .font(NCTypography.h3)
                    .foregroundColor(NCColors.charcoal)
                Text("痛みやしびれがあるときは無理をせず、必要に応じて専門家に相談してください。")
                    .font(NCTypography.body)
                    .foregroundColor(NCColors.softText)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private func settingToggle(title: String, subtitle: String, icon: String, isOn: Binding<Bool>) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(NCColors.deepSage)
                .frame(width: 42, height: 42)
                .background(NCColors.sage.opacity(0.14))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(NCTypography.h3)
                    .foregroundColor(NCColors.charcoal)
                Text(subtitle)
                    .font(NCTypography.caption)
                    .foregroundColor(NCColors.softText)
            }

            Spacer()
            Toggle(title, isOn: isOn)
                .labelsHidden()
                .tint(NCColors.deepSage)
        }
    }
}

struct SettingsPlaceholderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("設定")
                .font(NCTypography.h2)
                .foregroundColor(NCColors.nightText)
            Text("通知・音・表示設定は本番版で調整予定です。今はナイトモードの雰囲気と操作感を確認できます。")
                .font(NCTypography.caption)
                .foregroundColor(NCColors.nightText.opacity(0.66))
                .lineSpacing(3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
        .background(NCColors.nightCard.opacity(0.72))
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 22, style: .continuous).stroke(NCColors.sage.opacity(0.15), lineWidth: 1))
    }
}
