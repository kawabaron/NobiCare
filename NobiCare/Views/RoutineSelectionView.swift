import SwiftUI

struct RoutineSelectionView: View {
    @EnvironmentObject private var navigation: AppNavigationViewModel
    @State private var selectedSeconds = 60
    @State private var selectedPlace: Routine.Place = .chair
    @State private var appeared = false

    private var filteredRoutines: [Routine] {
        let exact = MockData.routines.filter { $0.durationSeconds == selectedSeconds && $0.place == selectedPlace }
        return exact.isEmpty ? MockData.routines.filter { $0.place == selectedPlace || $0.durationSeconds == selectedSeconds } : exact
    }

    var body: some View {
        ZStack {
            NCColors.ivory.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {
                    SectionHeader(title: "ルーティンを選ぶ", subtitle: "時間と場所を選んで、簡単に開始")
                        .appear(appeared, delay: 0)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("時間を選ぶ")
                            .font(NCTypography.caption.weight(.semibold))
                            .foregroundColor(NCColors.softText)
                        SegmentedTimeControl(selectedSeconds: $selectedSeconds)
                    }
                    .appear(appeared, delay: 0.08)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("場所を選ぶ")
                            .font(NCTypography.caption.weight(.semibold))
                            .foregroundColor(NCColors.softText)
                        HStack(spacing: 10) {
                            ForEach(Routine.Place.allCases, id: \.self) { place in
                                FilterChip(label: place.label, iconName: place.iconName, isSelected: selectedPlace == place) {
                                    withAnimation(.spring(response: 0.35, dampingFraction: 0.82)) {
                                        selectedPlace = place
                                    }
                                }
                            }
                        }
                    }
                    .appear(appeared, delay: 0.16)

                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "おすすめルーティン")
                        ForEach(Array(filteredRoutines.prefix(3).enumerated()), id: \.element.id) { index, routine in
                            RoutineCard(routine: routine) {
                                navigation.push(.execution(routine.id))
                            }
                            .appear(appeared, delay: 0.24 + Double(index) * 0.06)
                        }
                    }

                    Button {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.82)) {
                            selectedSeconds = 180
                        }
                    } label: {
                        Text("すべてのルーティンを見る")
                            .font(NCTypography.h3)
                            .foregroundColor(NCColors.deepSage)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                    }
                    .buttonStyle(PressableButtonStyle())
                    .appear(appeared, delay: 0.44)
                }
                .padding(.horizontal, NCSpacing.screen)
                .padding(.top, 20)
                .padding(.bottom, 28)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { appeared = true }
    }
}
