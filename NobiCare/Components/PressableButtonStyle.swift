import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.97
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed && !reduceMotion ? pressedScale : 1)
            .animation(reduceMotion ? nil : .spring(response: 0.35, dampingFraction: 0.82), value: configuration.isPressed)
    }
}
