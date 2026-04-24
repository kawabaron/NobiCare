import SwiftUI

struct ProgressView: View {
    @State private var appeared = false

    var body: some View {
        ZStack {
            NCColors.ivory.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {
                    SectionHeader(title: "記録", subtitle: "できた日も、休んだ日も、やさしく見える化")
                        .appear(appeared, delay: 0)

                    SoftCard {
                        VStack(alignment: .leading, spacing: 16) {
                            SectionHeader(title: "今週の記録")
                            WeeklyDotsView()
                            HStack {
                                metric("4日", caption: "今週の合計")
                                metric("6分", caption: "整えた時間")
                            }
                        }
                    }
                    .appear(appeared, delay: 0.08)

                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "よくケアする部位")
                        ForEach(Array(areaStats.enumerated()), id: \.element.0) { index, stat in
                            statRow(title: stat.0, count: stat.1, icon: stat.2)
                                .appear(appeared, delay: 0.16 + Double(index) * 0.05)
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "最近のルーティン")
                        ForEach(Array(recent.enumerated()), id: \.element.0) { index, item in
                            historyRow(title: item.0, time: item.1)
                                .appear(appeared, delay: 0.34 + Double(index) * 0.05)
                        }
                    }
                }
                .padding(.horizontal, NCSpacing.screen)
                .padding(.top, 20)
                .padding(.bottom, 28)
            }
        }
        .onAppear { appeared = true }
    }

    private let areaStats: [(String, String, String)] = [
        ("首", "4回", "person.crop.circle"),
        ("肩", "3回", "figure.arms.open"),
        ("腰", "2回", "figure.cooldown"),
        ("背中", "1回", "figure.flexibility")
    ]

    private let recent: [(String, String)] = [
        ("首前面ストレッチ", "今日 10:12"),
        ("肩まわりストレッチ", "昨日 21:45"),
        ("腰リフレッシュ", "5/22 07:30")
    ]

    private func metric(_ value: String, caption: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(value)
                .font(NCTypography.h1)
                .foregroundColor(NCColors.deepSage)
            Text(caption)
                .font(NCTypography.caption)
                .foregroundColor(NCColors.softText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func statRow(title: String, count: String, icon: String) -> some View {
        SoftCard {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(NCColors.deepSage)
                    .frame(width: 42, height: 42)
                    .background(NCColors.sage.opacity(0.14))
                    .clipShape(Circle())
                Text(title)
                    .font(NCTypography.h3)
                    .foregroundColor(NCColors.charcoal)
                Spacer()
                Text(count)
                    .font(NCTypography.h3)
                    .foregroundColor(NCColors.softText)
            }
        }
    }

    private func historyRow(title: String, time: String) -> some View {
        SoftCard {
            HStack(spacing: 12) {
                StretchFigureView(pose: .neckFront)
                    .frame(width: 48, height: 48)
                    .background(NCColors.ivory)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(NCTypography.h3)
                        .foregroundColor(NCColors.charcoal)
                    Text(time)
                        .font(NCTypography.caption)
                        .foregroundColor(NCColors.softText)
                }
                Spacer()
                Text("1分")
                    .font(NCTypography.caption.weight(.semibold))
                    .foregroundColor(NCColors.deepSage)
            }
        }
    }
}
