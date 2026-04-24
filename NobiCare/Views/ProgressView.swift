import SwiftUI

struct ProgressView: View {
    @EnvironmentObject private var careLogStore: CareLogStore
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
                            WeeklyDotsView(achieved: careLogStore.weeklyAchievements, accentIndex: careLogStore.currentWeekdayIndex)
                            HStack {
                                metric("\(careLogStore.totalDaysThisWeek)日", caption: "今週の合計")
                                metric("\(careLogStore.totalMinutesThisWeek)分", caption: "整えた時間")
                            }
                        }
                    }
                    .appear(appeared, delay: 0.08)

                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "よくケアする部位")
                        if careLogStore.areaStats.isEmpty {
                            emptyCard(title: "まだ記録はありません", message: "ルーティンを終えると、よくケアする部位がここに表示されます。")
                                .appear(appeared, delay: 0.16)
                        } else {
                            ForEach(Array(careLogStore.areaStats.prefix(4).enumerated()), id: \.offset) { index, stat in
                                statRow(title: stat.area, count: "\(stat.count)回", icon: iconName(for: stat.area))
                                    .appear(appeared, delay: 0.16 + Double(index) * 0.05)
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "最近のルーティン")
                        if careLogStore.recentEntries.isEmpty {
                            emptyCard(title: "完了したルーティンが入ります", message: "1分だけでも大丈夫。終えたものから順に残します。")
                                .appear(appeared, delay: 0.34)
                        } else {
                            ForEach(Array(careLogStore.recentEntries.enumerated()), id: \.element.id) { index, entry in
                                historyRow(entry: entry)
                                    .appear(appeared, delay: 0.34 + Double(index) * 0.05)
                            }
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

    private func historyRow(entry: CareLogEntry) -> some View {
        SoftCard {
            HStack(spacing: 12) {
                StretchFigureView(pose: MockData.routine(id: entry.routineId).steps.first?.poseType ?? .neckFront)
                    .frame(width: 48, height: 48)
                    .background(NCColors.ivory)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                VStack(alignment: .leading, spacing: 4) {
                    Text(entry.routineTitle)
                        .font(NCTypography.h3)
                        .foregroundColor(NCColors.charcoal)
                    Text(careLogStore.formattedCompletedAt(entry.completedAt))
                        .font(NCTypography.caption)
                        .foregroundColor(NCColors.softText)
                }
                Spacer()
                Text(MockData.routine(id: entry.routineId).durationLabel)
                    .font(NCTypography.caption.weight(.semibold))
                    .foregroundColor(NCColors.deepSage)
            }
        }
    }

    private func emptyCard(title: String, message: String) -> some View {
        SoftCard {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(NCTypography.h3)
                    .foregroundColor(NCColors.charcoal)
                Text(message)
                    .font(NCTypography.body)
                    .foregroundColor(NCColors.softText)
            }
        }
    }

    private func iconName(for area: String) -> String {
        switch area {
        case "首": return "person.crop.circle"
        case "肩": return "figure.arms.open"
        case "腰": return "figure.cooldown"
        case "背中": return "figure.flexibility"
        default: return "leaf"
        }
    }
}
