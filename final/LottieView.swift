import SwiftUI
#if canImport(Lottie)
import Lottie
import UIKit

struct LottieView: UIViewRepresentable {
    let name: String
    var loopMode: LottieLoopMode = .playOnce
    var speed: CGFloat = 1.0
    @Binding var play: Bool

    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .clear

        let animationView = LottieAnimationView(name: name)
        animationView.loopMode = loopMode
        animationView.animationSpeed = speed
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        context.coordinator.animationView = animationView
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        if play {
            context.coordinator.animationView?.currentProgress = 0
            context.coordinator.animationView?.play { _ in
                DispatchQueue.main.async {
                    self.play = false
                }
            }
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator() }

    class Coordinator {
        var animationView: LottieAnimationView?
    }
}
#else
// Fallback placeholder when Lottie is not available so the app still builds.
struct LottieView: View {
    let name: String
    var loopMode: Any = ()
    var speed: CGFloat = 1.0
    @Binding var play: Bool

    var body: some View {
        // Invisible placeholder; resets play to false immediately
        Color.clear
            .onAppear { if play { play = false } }
            .accessibilityHidden(true)
    }
}
#endif
