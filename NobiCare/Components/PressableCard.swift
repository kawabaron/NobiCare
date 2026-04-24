import SwiftUI

struct PressableCard<Content: View>: View {
    let action: () -> Void
    @ViewBuilder let content: Content

    var body: some View {
        Button(action: action) {
            SoftCard {
                content
            }
        }
        .buttonStyle(PressableButtonStyle(pressedScale: 0.98))
    }
}
