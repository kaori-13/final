import SwiftUI
#if canImport(Lottie)
import Lottie

// A SwiftUI wrapper around LottieAnimationView
struct LottieAnimationViewRepresentable: UIViewRepresentable {
    let name: String
    var loopMode: LottieLoopMode = .playOnce
    var contentMode: UIView.ContentMode = .scaleAspectFit
    var speed: CGFloat = 1.0

    func makeUIView(context: Context) -> UIView {
        let container = UIView()
        container.backgroundColor = .clear

        let animationView = LottieAnimationView(name: name)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = contentMode
        animationView.loopMode = loopMode
        animationView.animationSpeed = speed

        container.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            animationView.topAnchor.constraint(equalTo: container.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])

        // Start playing immediately
        animationView.play()

        // Store in context for updates
        context.coordinator.animationView = animationView
        return container
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // If needed, update properties dynamically
        context.coordinator.animationView?.loopMode = loopMode
        context.coordinator.animationView?.contentMode = contentMode
        context.coordinator.animationView?.animationSpeed = speed
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator {
        var animationView: LottieAnimationView?
    }
}

// A convenience overlay for showing wrong-answer animation full-screen with a dim background
struct WrongAnswerOverlay: View {
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.35)
                .ignoresSafeArea()
                .onTapGesture {
                    // allow dismiss on tap
                    isPresented = false
                }

            // Play once and disappear when finished
            LottieAutoDismissView(name: "False_Animation", isPresented: $isPresented)
                .frame(width: 280, height: 280)
                .accessibilityLabel(Text("Wrong answer animation"))
        }
        .opacity(isPresented ? 1 : 0)
        .animation(.easeInOut(duration: 0.25), value: isPresented)
    }
}

// Helper view that plays a Lottie animation and toggles isPresented to false when finished
private struct LottieAutoDismissView: UIViewRepresentable {
    let name: String
    @Binding var isPresented: Bool

    func makeUIView(context: Context) -> LottieAnimationView {
        let view = LottieAnimationView(name: name)
        view.contentMode = .scaleAspectFit
        view.loopMode = .playOnce
        view.animationSpeed = 1.0
        view.play { _ in
            // Auto dismiss when playback completes
            DispatchQueue.main.async {
                isPresented = false
            }
        }
        return view
    }

    func updateUIView(_ uiView: LottieAnimationView, context: Context) {
        // If the view is shown again, replay
        if isPresented && !uiView.isAnimationPlaying {
            uiView.currentProgress = 0
            uiView.play { _ in
                DispatchQueue.main.async {
                    isPresented = false
                }
            }
        }
    }
}

#else

// Fallback stubs when Lottie is not available, so the project can still build.
struct LottieAnimationViewRepresentable: View {
    let name: String
    var loopMode: Int = 0
    var contentMode: Int = 0
    var speed: CGFloat = 1.0
    var body: some View {
        Color.clear
    }
}

struct WrongAnswerOverlay: View {
    @Binding var isPresented: Bool
    var body: some View {
        EmptyView()
    }
}

#endif
