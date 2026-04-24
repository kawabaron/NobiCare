import SwiftUI

struct StretchFigureView: View {
    var pose: StretchPoseType = .neckFront
    var showsMotionCue = false

    var body: some View {
        GeometryReader { proxy in
            let w = proxy.size.width
            let h = proxy.size.height

            ZStack {
                chair(width: w, height: h)
                legs(width: w, height: h)
                torso(width: w, height: h)
                arms(width: w, height: h)
                head(width: w, height: h)
                highlight(width: w, height: h)
                if showsMotionCue {
                    motionCue(width: w, height: h)
                }
            }
            .frame(width: w, height: h)
        }
        .aspectRatio(1, contentMode: .fit)
        .accessibilityLabel(accessibilityLabel)
    }

    private func chair(width w: CGFloat, height h: CGFloat) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: w * 0.04)
                .stroke(Color(hex: 0xCFAF8B).opacity(0.85), lineWidth: 3)
                .frame(width: w * 0.38, height: h * 0.08)
                .offset(x: w * 0.14, y: h * 0.2)
            Rectangle()
                .fill(Color(hex: 0xCFAF8B).opacity(0.68))
                .frame(width: 3, height: h * 0.26)
                .offset(x: w * 0.31, y: h * 0.36)
            Rectangle()
                .fill(Color(hex: 0xCFAF8B).opacity(0.68))
                .frame(width: 3, height: h * 0.26)
                .offset(x: -w * 0.01, y: h * 0.36)
            RoundedRectangle(cornerRadius: w * 0.04)
                .stroke(Color(hex: 0xCFAF8B).opacity(0.72), lineWidth: 3)
                .frame(width: w * 0.1, height: h * 0.42)
                .offset(x: w * 0.31, y: -h * 0.02)
        }
    }

    private func legs(width w: CGFloat, height h: CGFloat) -> some View {
        ZStack {
            Capsule()
                .fill(NCColors.sage.opacity(0.74))
                .overlay(Capsule().stroke(Color(hex: 0x8A7F72), lineWidth: 1.1))
                .frame(width: w * 0.12, height: h * 0.36)
                .rotationEffect(.degrees(-5))
                .offset(x: -w * 0.06, y: h * 0.34)
            Capsule()
                .fill(NCColors.sage.opacity(0.74))
                .overlay(Capsule().stroke(Color(hex: 0x8A7F72), lineWidth: 1.1))
                .frame(width: w * 0.12, height: h * 0.36)
                .rotationEffect(.degrees(5))
                .offset(x: w * 0.15, y: h * 0.34)
            Capsule()
                .fill(Color(hex: 0xF6E4D0))
                .frame(width: w * 0.16, height: h * 0.035)
                .rotationEffect(.degrees(-8))
                .offset(x: -w * 0.08, y: h * 0.54)
            Capsule()
                .fill(Color(hex: 0xF6E4D0))
                .frame(width: w * 0.16, height: h * 0.035)
                .rotationEffect(.degrees(8))
                .offset(x: w * 0.17, y: h * 0.54)
        }
    }

    private func torso(width w: CGFloat, height h: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: w * 0.09, style: .continuous)
            .fill(Color.white.opacity(0.96))
            .overlay(
                RoundedRectangle(cornerRadius: w * 0.09, style: .continuous)
                    .stroke(Color(hex: 0x8A7F72).opacity(0.82), lineWidth: 1.2)
            )
            .frame(width: w * 0.24, height: h * 0.34)
            .rotationEffect(.degrees(torsoRotation))
            .offset(x: w * torsoOffsetX, y: h * torsoOffsetY)
    }

    private func arms(width w: CGFloat, height h: CGFloat) -> some View {
        ZStack {
            Capsule()
                .fill(Color(hex: 0xF6E4D0))
                .overlay(Capsule().stroke(Color(hex: 0x8A7F72).opacity(0.75), lineWidth: 1))
                .frame(width: w * 0.075, height: h * 0.32)
                .rotationEffect(.degrees(leftArmRotation))
                .offset(x: w * leftArmOffsetX, y: h * leftArmOffsetY)
            Capsule()
                .fill(Color(hex: 0xF6E4D0))
                .overlay(Capsule().stroke(Color(hex: 0x8A7F72).opacity(0.75), lineWidth: 1))
                .frame(width: w * 0.075, height: h * 0.32)
                .rotationEffect(.degrees(rightArmRotation))
                .offset(x: w * rightArmOffsetX, y: h * rightArmOffsetY)
        }
    }

    private func head(width w: CGFloat, height h: CGFloat) -> some View {
        ZStack {
            Circle()
                .fill(Color(hex: 0xF6E4D0))
                .overlay(Circle().stroke(Color(hex: 0x8A7F72), lineWidth: 1.1))
                .frame(width: w * 0.21)
                .offset(x: w * headOffsetX, y: h * headOffsetY)
            Capsule()
                .fill(Color(hex: 0x9B7F64).opacity(0.86))
                .frame(width: w * 0.25, height: h * 0.14)
                .rotationEffect(.degrees(hairRotation))
                .offset(x: w * (headOffsetX - 0.015), y: h * (headOffsetY - 0.075))
            HStack(spacing: w * 0.045) {
                Circle().fill(NCColors.charcoal.opacity(0.75)).frame(width: w * 0.013)
                Circle().fill(NCColors.charcoal.opacity(0.75)).frame(width: w * 0.013)
            }
            .offset(x: w * headOffsetX, y: h * (headOffsetY + 0.01))
            Capsule()
                .fill(NCColors.mutedCoral.opacity(0.5))
                .frame(width: w * 0.06, height: h * 0.018)
                .offset(x: w * headOffsetX, y: h * (headOffsetY + 0.055))
        }
    }

    private func highlight(width w: CGFloat, height h: CGFloat) -> some View {
        Circle()
            .fill(NCColors.mutedCoral.opacity(0.35))
            .blur(radius: 0.4)
            .frame(width: w * highlightSize)
            .offset(x: w * highlightOffsetX, y: h * highlightOffsetY)
    }

    private func motionCue(width w: CGFloat, height h: CGFloat) -> some View {
        Image(systemName: motionCueIcon)
            .font(.system(size: max(w * 0.11, 16), weight: .bold))
            .foregroundColor(NCColors.deepSage)
            .padding(w * 0.035)
            .background(Color.white.opacity(0.72))
            .clipShape(Circle())
            .overlay(Circle().stroke(NCColors.sage.opacity(0.38), lineWidth: 1))
            .offset(x: w * motionCueOffsetX, y: h * motionCueOffsetY)
            .accessibilityHidden(true)
    }

    private var torsoRotation: Double {
        switch pose {
        case .back: return 16
        case .sideBend: return -12
        default: return 0
        }
    }

    private var torsoOffsetX: CGFloat { pose == .back ? 0.04 : 0.02 }
    private var torsoOffsetY: CGFloat { pose == .back ? -0.02 : -0.04 }
    private var headOffsetX: CGFloat { pose == .sideBend ? -0.05 : (pose == .back ? 0.1 : 0.02) }
    private var headOffsetY: CGFloat { pose == .back ? -0.29 : -0.31 }
    private var hairRotation: Double { pose == .neckFront ? -8 : (pose == .back ? 12 : 0) }
    private var leftArmRotation: Double {
        switch pose {
        case .neckFront: return -138
        case .shoulder: return -18
        case .back: return 68
        case .sideBend: return -146
        }
    }
    private var rightArmRotation: Double {
        switch pose {
        case .neckFront: return 140
        case .shoulder: return 18
        case .back: return -58
        case .sideBend: return -138
        }
    }
    private var leftArmOffsetX: CGFloat {
        switch pose {
        case .neckFront: return -0.05
        case .shoulder: return -0.11
        case .back: return -0.18
        case .sideBend: return -0.09
        }
    }
    private var leftArmOffsetY: CGFloat {
        switch pose {
        case .neckFront: return -0.23
        case .shoulder: return -0.04
        case .back: return -0.03
        case .sideBend: return -0.22
        }
    }
    private var rightArmOffsetX: CGFloat {
        switch pose {
        case .neckFront: return 0.13
        case .shoulder: return 0.16
        case .back: return 0.22
        case .sideBend: return 0.08
        }
    }
    private var rightArmOffsetY: CGFloat {
        switch pose {
        case .neckFront: return -0.24
        case .shoulder: return -0.03
        case .back: return 0.0
        case .sideBend: return -0.24
        }
    }
    private var highlightSize: CGFloat {
        switch pose {
        case .neckFront: return 0.18
        case .shoulder: return 0.25
        case .back: return 0.28
        case .sideBend: return 0.24
        }
    }
    private var highlightOffsetX: CGFloat {
        switch pose {
        case .neckFront: return 0.02
        case .shoulder: return 0.06
        case .back: return 0.12
        case .sideBend: return -0.05
        }
    }
    private var highlightOffsetY: CGFloat {
        switch pose {
        case .neckFront: return -0.2
        case .shoulder: return -0.12
        case .back: return 0.02
        case .sideBend: return -0.08
        }
    }

    private var motionCueIcon: String {
        switch pose {
        case .neckFront: return "arrow.up"
        case .shoulder: return "arrow.clockwise"
        case .back: return "arrow.up.forward"
        case .sideBend: return "arrow.left.and.right"
        }
    }

    private var motionCueOffsetX: CGFloat {
        switch pose {
        case .neckFront: return 0.23
        case .shoulder: return -0.24
        case .back: return -0.22
        case .sideBend: return 0.24
        }
    }

    private var motionCueOffsetY: CGFloat {
        switch pose {
        case .neckFront: return -0.28
        case .shoulder: return -0.1
        case .back: return -0.04
        case .sideBend: return -0.16
        }
    }

    private var accessibilityLabel: String {
        switch pose {
        case .neckFront: return "首の前側を伸ばすイラスト"
        case .shoulder: return "肩を回すイラスト"
        case .back: return "背中を伸ばすイラスト"
        case .sideBend: return "体側を伸ばすイラスト"
        }
    }
}
