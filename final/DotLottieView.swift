import SwiftUI

#if canImport(DotLottie)
import DotLottie

struct DotLottieView: View {
    let fileName: String
    @Binding var play: Bool
    var loop: Bool = false

    private let animation: DotLottieAnimation

    init(fileName: String, play: Binding<Bool>, loop: Bool = false) {
        self.fileName = fileName
        self._play = play
        self.loop = loop
        self.animation = DotLottieAnimation(fileName: fileName, config: AnimationConfig(loop: loop))
    }

    var body: some View {
        ZStack {
            animation.view()
                .onChange(of: play) { _, newValue in
                    if newValue {
                        animation.play()
                        if !loop {
                            // Try to reset play flag after a short delay (no duration callback in this wrapper)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                                self.play = false
                            }
                        }
                    } else {
                        animation.pause()
                    }
                }
                .onAppear {
                    if play { animation.play() }
                }
        }
    }
}
#else
// Fallback placeholder when DotLottie is not available so the app still builds.
struct DotLottieView: View {
    let fileName: String
    @Binding var play: Bool
    var loop: Bool = false

    var body: some View {
        Color.clear
            .onAppear { if play { play = false } }
            .accessibilityHidden(true)
    }
}
#endif
