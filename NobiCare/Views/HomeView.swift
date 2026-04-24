import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var navigation: AppNavigationViewModel
    @State private var selectedAreaId = MockData.bodyAreas[0].id
    @State private var appeared = false

    private var selectedArea: BodyArea {
        MockData.bodyAreas.first { $0.id == selectedAreaId } ?? MockData.bodyAreas[0]
    }

    private var recommendedRoutine: Routine {
        MockData.routine(id: selectedArea.recommendedRoutineId)
    }

    var body: some View {
        ZStack {
            NCColors.ivory.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {
                    header
                        .appear(appeared, delay: 0)

                    SectionHeader(title: "気になる部位を選んでください")
                        .appear(appeared, delay: 0.08)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(Array(MockData.bodyAreas.enumerated()), id: \.element.id) { index, area in
                            BodyAreaCard(area: area, isSelected: selectedAreaId == area.id) {
                                withAnimation(.spring(response: 0.35, dampingFraction: 0.82)) {
                                    selectedAreaId = area.id
                                }
                            }
                            .appear(appeared, delay: 0.14 + Double(index) * 0.05)
                        }
                    }

                    recommendation
                        .appear(appeared, delay: 0.36)

                    PrimaryButton(title: "\(recommendedRoutine.durationLabel)だけ始める", iconName: "leaf.fill", action: startRecommendedRoutine)
                    .appear(appeared, delay: 0.44)
                }
                .padding(.horizontal, NCSpacing.screen)
                .padding(.top, 18)
                .padding(.bottom, 28)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            withAnimation { appeared = true }
        }
    }

    private var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                Text("おはようございます")
                    .font(NCTypography.h1)
                    .foregroundColor(NCColors.charcoal)
                Text("今日も、やさしく整えましょう。")
                    .font(NCTypography.body)
                    .foregroundColor(NCColors.softText)
            }
            Spacer()
            MascotView(mood: .neutral, size: 74)
                .padding(.top, 4)
        }
    }

    private var recommendation: some View {
        PressableCard(action: startRecommendedRoutine) {
            VStack(alignment: .leading, spacing: 14) {
                SectionHeader(title: "あなたへのおすすめ", subtitle: recommendedRoutine.title)
                HStack(spacing: 8) {
                    Text(recommendedRoutine.targetAreas.joined(separator: "・"))
                    Text(recommendedRoutine.durationLabel)
                    Text(recommendedRoutine.place.label)
                }
                .font(NCTypography.caption.weight(.semibold))
                .foregroundColor(NCColors.deepSage)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(NCColors.sage.opacity(0.15))
                .clipShape(Capsule())

                HStack {
                    Text(recommendedRoutine.description)
                        .font(NCTypography.body)
                        .foregroundColor(NCColors.softText)
                    Spacer()
                    Image(systemName: "arrow.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(NCColors.deepSage)
                }
            }
        }
        .accessibilityHint("\(recommendedRoutine.title)を開始します")
    }

    private func startRecommendedRoutine() {
        navigation.push(.execution(recommendedRoutine.id))
    }
}

extension View {
    func appear(_ appeared: Bool, delay: Double) -> some View {
        self
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : 12)
            .animation(.easeOut(duration: 0.42).delay(delay), value: appeared)
    }
}
