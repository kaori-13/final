//
//  Game.swift
//  final
//
//  Created by Fanny on 2025/12/16.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var appState: AppState


    struct Question {
        let text: String
        let options: [String]
        let correctIndex: Int
    }

    private let questions: [Question] = [
        .init(
            text: "The project team must ___ the deadline for the final report.",
            options: ["meet", "reach", "contact", "arrive"],
            correctIndex: 0
        ),
        .init(
            text: "Please ___ the attached file before the meeting.",
            options: ["review", "revise", "reserve", "remove"],
            correctIndex: 0
        ),
        .init(
            text: "We need to ___ a decision by Friday.",
            options: ["make", "do", "take", "put"],
            correctIndex: 0
        ),
        .init(
            text: "We need to ___ a decision by Friday.",
            options: ["make", "do", "take", "put"],
            correctIndex: 0
        ),
        .init(
            text: "We need to ___ a decision by Friday.",
            options: ["make", "do", "take", "put"],
            correctIndex: 0
        ),
        .init(
            text: "We need to ___ a decision by Friday.",
            options: ["make", "do", "take", "put"],
            correctIndex: 0
        ),
        .init(
            text: "We need to ___ a decision by Friday.",
            options: ["make", "do", "take", "put"],
            correctIndex: 0
        ),
        .init(
            text: "We need to ___ a decision by Friday.",
            options: ["make", "do", "take", "put"],
            correctIndex: 0
        ),
        .init(
            text: "We need to ___ a decision by Friday.",
            options: ["make", "do", "take", "put"],
            correctIndex: 0
        ),
        .init(
            text: "We need to ___ a decision by Friday.",
            options: ["make", "do", "take", "put"],
            correctIndex: 0
        )
        
    ]

    // quiz progress
    @State private var currentIndex = 0
    @State private var correctCount = 0
    @State private var answeredCount = 0

    // ui state
    @State private var selectedIndex: Int? = nil
    @State private var showResult = false
    @State private var isLocked = false

    // navigation
    @State private var showSummary = false

    var body: some View {
        let q = questions[currentIndex]

        ZStack {
            Color.blue.opacity(0.1).ignoresSafeArea()

            VStack(alignment: .leading, spacing: 16) {

                // HUD: progress + score
                HStack {
                    Text("Q\(currentIndex + 1)/\(questions.count)")
                        .font(.headline)
                        .opacity(0.75)

                    Spacer()

                    Text("Score: \(correctCount)")
                        .font(.headline)
                }

                if answeredCount > 0 {
                    let rate = Double(correctCount) / Double(answeredCount) * 100
                    Text(String(format: "Accuracy: %.0f%%", rate))
                        .font(.subheadline)
                        .opacity(0.7)
                }

                Text(q.text)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 6)

                ForEach(q.options.indices, id: \.self) { i in
                    Button {
                        handleTap(option: i, correctIndex: q.correctIndex)
                    } label: {
                        HStack(spacing: 12) {
                            Text(letter(for: i) + ".")
                                .fontWeight(.bold)

                            Text(q.options[i])

                            Spacer()

                            if showResult, let selectedIndex {
                                if i == q.correctIndex {
                                    Image(systemName: "checkmark.circle.fill")
                                } else if i == selectedIndex {
                                    Image(systemName: "xmark.circle.fill")
                                }
                            }
                        }
                        .padding()
                        .background(optionBackground(i: i, correctIndex: q.correctIndex))
                        .foregroundStyle(.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .disabled(isLocked)
                }

                if showResult {
                    Text(selectedIndex == q.correctIndex
                         ? "✅ Correct!"
                         : "❌ Wrong. Correct answer: \(q.options[q.correctIndex])")
                    .font(.headline)
                    .padding(.top, 6)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("下一個")
        .navigationDestination(isPresented: $showSummary) {
            ResultView(
                total: questions.count,
                correct: correctCount
            ) {
                resetQuiz()
            }
        }
    }

    // MARK: - Quiz Logic

    private func handleTap(option i: Int, correctIndex: Int) {
        guard !isLocked else { return }

        selectedIndex = i
        showResult = true
        isLocked = true

        answeredCount += 1
        let isCorrect = (i == correctIndex)
        if isCorrect { correctCount += 1 }

        if isCorrect {
            // 答對：立刻下一題（留一點點時間顯示回饋）
            Task { @MainActor in
                try? await Task.sleep(nanoseconds: 250_000_000) // 0.25 秒
                advanceOrFinish()
            }
        } else {
            // 答錯：停 3 秒再下一題
            Task { @MainActor in
                try? await Task.sleep(nanoseconds: 3_000_000_000)
                advanceOrFinish()
            }
        }
    }

    @MainActor
    private func advanceOrFinish() {
        if currentIndex == questions.count - 1 {
            let score = correctCount * 100   // ✅ 你可以改成你的計分方式
            appState.updateHighScore(player: appState.activePlayerName, newScore: score)
            showSummary = true
            return
        }

        currentIndex += 1
        selectedIndex = nil
        showResult = false
        isLocked = false
    }

    private func resetQuiz() {
        currentIndex = 0
        correctCount = 0
        answeredCount = 0
        selectedIndex = nil
        showResult = false
        isLocked = false
        showSummary = false
    }

    // MARK: - UI Helpers

    private func letter(for index: Int) -> String {
        ["A", "B", "C", "D"][index]
    }

    private func optionBackground(i: Int, correctIndex: Int) -> Color {
        guard showResult else { return .white.opacity(0.9) }
        if i == correctIndex { return .green.opacity(0.25) }
        if i == selectedIndex { return .red.opacity(0.20) }
        return .white.opacity(0.9)
    }
}

struct ResultView: View {
    let total: Int
    let correct: Int
    let onRestart: () -> Void

    var body: some View {
        let rate = total == 0 ? 0 : Double(correct) / Double(total) * 100

        ZStack {
            Color.blue.opacity(0.1).ignoresSafeArea()

            VStack(spacing: 16) {
                Text("完成！")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Score: \(correct) / \(total)")
                    .font(.title2)

                Text(String(format: "Accuracy: %.1f%%", rate))
                    .font(.title3)
                    .opacity(0.8)

                Button {
                    onRestart()
                } label: {
                    Text("再玩一次")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.25))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.top, 10)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("結果")
    }
}


//struct GameView: View {
//    
//    var body: some View {
//        ZStack {
//            Color.blue.opacity(0.1).ignoresSafeArea() // 背景色
//            VStack {
//                Text("The project team must ___ the deadline for the final report.")
//                    .font(.largeTitle)
//                    .padding()
//                Text("A: meet")
//                    .padding()
//                Text("B: reach")
//                    .padding()
//                Text("C: contact")
//                    .padding()
//                Text("D: arrive")
//                    .padding()
//            }
//        }
//        .navigationTitle("下一個") // 設定第二個畫面頂部的標題
//    }
//}

//struct HomeView: View {
//    @Binding var path: NavigationPath
//
//    var body: some View {
//        ZStack {
//            Image("bg1")
//                .scaledToFit()
//                .ignoresSafeArea()
//                .opacity(0.9)
//
//            VStack(spacing: 20) {
//
//                Text("Masterpiece Quest")
//                    .foregroundStyle(.white)
//                    .font(.system(size: 25,weight: .bold,design: .serif))
//
//                Text("藝術鑑賞家")
//                    .font(.system(size: 60,weight: .bold,design: .serif))
//                    .foregroundStyle(.white)
//                    .shadow(radius: 20)
//
//                Button("開始測驗") {
//                    path.append("quiz")  // ← Push QuizView
//                }
//                .font(.title2)
//                .fontWeight(.bold)
//                .padding()
//                .frame(width:150)
//                .background(Color(red: 97/255, green: 37/255, blue: 30/255))
//                .foregroundStyle(.background)
//                .cornerRadius(30)
//            }
//        }
//        .navigationDestination(for: String.self) { value in
//            if value == "quiz" {
//                QuizView(path: $path)
//            }
//        }
//    }
//}
//
//struct QuizView: View {
//    @Binding var path: NavigationPath
//    @State private var showResult = false
//
//    var body: some View {
//            .navigationDestination(isPresented: $showResult) {
//                ResultView(path: $path)
//            }
//    }
//    
//    struct ResultView: View {
//        @Binding var path: NavigationPath
//
//        var body: some View {
//            VStack(spacing: 20) {
//
//                Text("鑑定結果")
//
//                Button("回到首頁") {
//                    path.removeLast(path.count)  // ← 回到最根部 HomeView
//                }
//                .fontWeight(.bold)
//                .padding()
//                .frame(width: 150)
//                .background(Color(red: 97/255, green: 37/255, blue: 30/255))
//                .foregroundStyle(.background)
//                .cornerRadius(30)
//            }
//        }
//    }
//
//    func endGame() {
//        showResult = true
//    }
//}

#Preview {
    GameView()
}
