import SwiftUI

struct RoutineSelectionView: View {
    @EnvironmentObject private var navigation: AppNavigationViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedSeconds = 60
    @State private var selectedPlace: Routine.Place = .chair
    @State private var showAllRoutines = false
    @State private var appeared = false

    private var filteredRoutines: [Routine] {
        if showAllRoutines {
            return MockData.routines
        }
        let exact = MockData.routines.filter { $0.durationSeconds == selectedSeconds && $0.place == selectedPlace }
        return exact
    }

    var body: some View {
        ZStack {
            NCColors.ivory.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {
                    routineHeader
                        .appear(appeared, delay: 0)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("時間を選ぶ")
                            .font(NCTypography.caption.weight(.semibold))
                            .foregroundColor(NCColors.softText)
                        SegmentedTimeControl(selectedSeconds: $selectedSeconds) {
                            showAllRoutines = false
                        }
                    }
                    .appear(appeared, delay: 0.08)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("場所を選ぶ")
                            .font(NCTypography.caption.weight(.semibold))
                            .foregroundColor(NCColors.softText)
                        HStack(spacing: 10) {
                            ForEach(Routine.Place.allCases, id: \.self) { place in
                                FilterChip(label: place.label, iconName: place.iconName, isSelected: selectedPlace == place) {
                                    selectedPlace = place
                                    showAllRoutines = false
                                }
                            }
                        }
                    }
                    .appear(appeared, delay: 0.16)

                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: showAllRoutines ? "すべてのルーティン" : "おすすめルーティン")
                        if filteredRoutines.isEmpty {
                            emptyState
                                .appear(appeared, delay: 0.24)
                        } else {
                            ForEach(Array(filteredRoutines.prefix(showAllRoutines ? filteredRoutines.count : 3).enumerated()), id: \.element.id) { index, routine in
                                RoutineCard(routine: routine) {
                                    navigation.push(.execution(routine.id))
                                }
                                .appear(appeared, delay: 0.24 + Double(index) * 0.06)
                            }
                        }
                    }
                    .transaction { transaction in
                        if appeared {
                            transaction.animation = nil
                        }
                    }

                    Button {
                        showAllRoutines = true
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
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { appeared = true }
    }

    private var routineHeader: some View {
        VStack(alignment: .leading, spacing: 18) {
            if navigation.selectedTab == .home {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(NCColors.charcoal)
                        .frame(width: 42, height: 42)
                        .background(NCColors.cream.opacity(0.94))
                        .clipShape(Circle())
                        .overlay(Circle().stroke(NCColors.border.opacity(0.8), lineWidth: 1))
                }
                .buttonStyle(PressableButtonStyle())
            }

            SectionHeader(title: "ルーティンを選ぶ", subtitle: "時間と場所を選んで、簡単に開始")
        }
    }

    private var emptyState: some View {
        SoftCard {
            VStack(alignment: .leading, spacing: 10) {
                Text("この条件のルーティンは準備中です")
                    .font(NCTypography.h3)
                    .foregroundColor(NCColors.charcoal)
                Text("時間か場所を変えるか、すべてのルーティンから選んでください。")
                    .font(NCTypography.body)
                    .foregroundColor(NCColors.softText)
            }
        }
    }
}
