import SwiftUI

enum MascotMood {
    case neutral
    case happy
    case sleepy
    case cheering
}

struct MascotView: View {
    var mood: MascotMood = .neutral
    var size: CGFloat = 112
    @State private var breathe = false

    var body: some View {
        ZStack {
            bodyShape
            leaves
            arms
            face
            feet
            accent
        }
        .frame(width: size, height: size * 1.22)
        .scaleEffect(breathe ? 1.018 : 1)
        .offset(y: mood == .sleepy && breathe ? 4 : (breathe ? -2 : 0))
        .animation(.easeInOut(duration: mood == .sleepy ? 2.4 : 1.9).repeatForever(autoreverses: true), value: breathe)
        .onAppear { breathe = true }
        .accessibilityLabel("のびのびくん")
    }

    private var bodyShape: some View {
        RoundedRectangle(cornerRadius: size * 0.32, style: .continuous)
            .fill(
                LinearGradient(
                    colors: [Color(hex: 0xFFF5DD), Color(hex: 0xF8E9C7)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay(
                RoundedRectangle(cornerRadius: size * 0.32, style: .continuous)
                    .stroke(NCColors.deepSage.opacity(0.86), lineWidth: 2)
            )
            .frame(width: size * 0.62, height: size * 0.86)
            .offset(y: size * 0.13)
    }

    private var leaves: some View {
        ZStack {
            Capsule()
                .fill(NCColors.sage)
                .overlay(Capsule().stroke(NCColors.deepSage, lineWidth: 1.2))
                .frame(width: size * 0.22, height: size * 0.11)
                .rotationEffect(.degrees(-28))
                .offset(x: -size * 0.08, y: -size * 0.42)
            Capsule()
                .fill(NCColors.sage.opacity(0.92))
                .overlay(Capsule().stroke(NCColors.deepSage, lineWidth: 1.2))
                .frame(width: size * 0.22, height: size * 0.11)
                .rotationEffect(.degrees(24))
                .offset(x: size * 0.08, y: -size * 0.42)
            Capsule()
                .fill(NCColors.deepSage.opacity(0.75))
                .frame(width: 2, height: size * 0.14)
                .offset(y: -size * 0.34)
        }
    }

    private var arms: some View {
        ZStack {
            Capsule()
                .stroke(NCColors.deepSage.opacity(0.86), lineWidth: 2)
                .frame(width: size * 0.12, height: size * armHeight)
                .rotationEffect(.degrees(leftArmRotation))
                .offset(x: -size * 0.36, y: leftArmOffsetY)
            Capsule()
                .stroke(NCColors.deepSage.opacity(0.86), lineWidth: 2)
                .frame(width: size * 0.12, height: size * armHeight)
                .rotationEffect(.degrees(rightArmRotation))
                .offset(x: size * 0.36, y: rightArmOffsetY)
        }
    }

    private var face: some View {
        VStack(spacing: 7) {
            HStack(spacing: size * 0.12) {
                eye
                eye
            }
            mouth
        }
        .offset(y: -size * 0.01)
        .overlay(
            HStack(spacing: size * 0.28) {
                Circle().fill(NCColors.mutedCoral.opacity(0.58)).frame(width: size * 0.055)
                Circle().fill(NCColors.mutedCoral.opacity(0.58)).frame(width: size * 0.055)
            }
            .offset(y: size * 0.04)
        )
    }

    private var eye: some View {
        Group {
            if mood == .sleepy {
                Capsule()
                    .fill(NCColors.charcoal.opacity(0.75))
                    .frame(width: size * 0.055, height: 2)
            } else {
                Circle()
                    .fill(NCColors.charcoal.opacity(0.78))
                    .frame(width: size * 0.038, height: size * 0.038)
            }
        }
    }

    private var mouth: some View {
        Group {
            if mood == .happy || mood == .cheering {
                SmileMouth()
                    .stroke(NCColors.charcoal.opacity(0.72), style: StrokeStyle(lineWidth: 1.6, lineCap: .round))
                    .frame(width: size * 0.12, height: size * 0.055)
            } else {
                Capsule()
                    .fill(NCColors.charcoal.opacity(0.72))
                    .frame(width: size * 0.05, height: 2)
            }
        }
    }

    private var feet: some View {
        HStack(spacing: size * 0.13) {
            Capsule().fill(NCColors.deepSage.opacity(0.8)).frame(width: size * 0.12, height: size * 0.035)
            Capsule().fill(NCColors.deepSage.opacity(0.8)).frame(width: size * 0.12, height: size * 0.035)
        }
        .offset(y: size * 0.55)
    }

    @ViewBuilder
    private var accent: some View {
        if mood == .happy {
            Image(systemName: "heart.fill")
                .foregroundColor(NCColors.mutedCoral)
                .font(.system(size: size * 0.16))
                .offset(x: size * 0.45, y: size * 0.18)
        } else if mood == .sleepy {
            Image(systemName: "moon.fill")
                .foregroundColor(NCColors.gentleRose)
                .font(.system(size: size * 0.14))
                .offset(x: size * 0.42, y: -size * 0.24)
        }
    }

    private var armHeight: CGFloat { mood == .neutral || mood == .sleepy ? 0.3 : 0.42 }
    private var leftArmRotation: Double { mood == .cheering ? -14 : (mood == .sleepy ? 34 : 6) }
    private var rightArmRotation: Double { mood == .cheering ? -150 : (mood == .sleepy ? -34 : -6) }
    private var leftArmOffsetY: CGFloat { mood == .cheering ? -size * 0.05 : size * 0.12 }
    private var rightArmOffsetY: CGFloat { mood == .cheering ? -size * 0.2 : size * 0.12 }
}

private struct SmileMouth: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY - rect.height * 0.1))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.midY - rect.height * 0.1),
            control: CGPoint(x: rect.midX, y: rect.maxY)
        )
        return path
    }
}
