import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var navigation: AppNavigationViewModel
    @State private var selectedAreaId = MockData.bodyAreas[0].id
    @State private var appeared = false

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

                    PrimaryButton(title: "1分だけ始める", iconName: "leaf.fill") {
                        navigation.push(.routineSelection)
                    }
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
        PressableCard {
            navigation.push(.routineSelection)
        } content: {
            VStack(alignment: .leading, spacing: 14) {
                SectionHeader(title: "あなたへのおすすめ", subtitle: "やさしく始める1分ルーティン")
                HStack(spacing: 8) {
                    Text("首・肩")
                    Text("1分")
                    Text("椅子")
                }
                .font(NCTypography.caption.weight(.semibold))
                .foregroundColor(NCColors.deepSage)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(NCColors.sage.opacity(0.15))
                .clipShape(Capsule())

                HStack {
                    Text("今の体に合わせて、短く静かに始めます。")
                        .font(NCTypography.body)
                        .foregroundColor(NCColors.softText)
                    Spacer()
                    Image(systemName: "arrow.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(NCColors.deepSage)
                }
            }
        }
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
