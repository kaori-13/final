//
//  Game.swift
//  final
//
//  Created by Fanny on 2025/12/16.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var appState: AppState
    @Binding var path: NavigationPath

    struct Question {
        let text: String
        let options: [String]
        let correctAnswer: String
        var correctIndex: Int { options.firstIndex(of: correctAnswer) ?? 0 }
    }

    // ✅ 題庫（剛好 10 題）
    private let allQuestions: [Question] = [
        Question(
            text: """
                            
                            If you put a ______ under a leaking faucet, you will be surprised at the amount of water collected in
                                 24 hours.
                """,
            options: ["border", "timer", "container", "marker"],
            correctAnswer: "container"
        ),
        Question(
            text: """
                The local farmers’ market is popular as it offers a variety of fresh seasonal ______ to people in the community.
                """,
            options: ["produce", "fashion", "brand", "trend"],
            correctAnswer: "container"
        ),
        // 你就一直加題目在這裡
    ]

    @State private var questions: [Question] = []

    // quiz progress
    @State private var currentIndex = 0
    @State private var correctCount = 0
    @State private var answeredCount = 0

    // ui state
    @State private var selectedIndex: Int? = nil
    @State private var showResult = false
    @State private var isLocked = false

    var body: some View {
        ZStack {
            Color.blue.opacity(0.1).ignoresSafeArea()

            if questions.indices.contains(currentIndex) {
                let q = questions[currentIndex]

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
                        let rate =
                            Double(correctCount) / Double(answeredCount) * 100
                        Text(String(format: "Accuracy: %.0f%%", rate))
                            .font(.subheadline)
                            .opacity(0.7)
                    }

                    Text(q.text)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
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
                                        Image(
                                            systemName: "checkmark.circle.fill"
                                        )
                                    } else if i == selectedIndex {
                                        Image(systemName: "xmark.circle.fill")
                                    }
                                }
                            }
                            .padding()
                            .background(
                                optionBackground(
                                    i: i,
                                    correctIndex: q.correctIndex
                                )
                            )
                            .foregroundStyle(.primary)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .disabled(isLocked)
                    }

                    if showResult {
                        Text(
                            selectedIndex == q.correctIndex
                                ? "✅ Correct!"
                                : "❌ Wrong. Correct answer: \(q.options[q.correctIndex])"
                        )
                        .font(.headline)
                        .padding(.top, 6)
                    }

                    Spacer()
                }
                .padding()
            } else {
                // Loading / placeholder while questions are being prepared
                ProgressView("載入題目中…")
                    .task {
                        if questions.isEmpty {
                            startNewGame()
                        }
                    }
            }
        }
        .navigationTitle("下一個")
    }

    // MARK: - Quiz Logic

    private func handleTap(option i: Int, correctIndex: Int) {
        guard !isLocked else { return }

        let q = questions[currentIndex]

        selectedIndex = i
        showResult = true
        isLocked = true

        answeredCount += 1
        let isCorrect = (i == correctIndex)

        if !isCorrect {
            let selectedWord = q.options[i]
            appState.addWrongRecord(
                question: q.text,
                correct: q.options[correctIndex],
                selected: selectedWord
            )
        }

        if isCorrect { correctCount += 1 }

        if isCorrect {
            // 答對：很快換下一題
            Task { @MainActor in
                try? await Task.sleep(nanoseconds: 250_000_000)  // 0.25 秒
                advanceOrFinish()
            }
        } else {
            // 答錯：停 3 秒再換下一題
            Task { @MainActor in
                try? await Task.sleep(nanoseconds: 3_000_000_000)
                advanceOrFinish()
            }
        }
    }

    @MainActor
    private func advanceOrFinish() {
        if currentIndex == questions.count - 1 {
            // ✅ 存高分
            let score = correctCount * 100
            appState.updateHighScore(
                player: appState.activePlayerName,
                newScore: score
            )

            // ✅ 回首頁（清空 NavigationStack）
            path = NavigationPath()
            return
        }

        // 下一題
        currentIndex += 1
        selectedIndex = nil
        showResult = false
        isLocked = false
    }

    // MARK: - UI Helpers

    private func letter(for index: Int) -> String {
        let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ").map(String.init)
        return index < letters.count ? letters[index] : "#"
    }

    private func optionBackground(i: Int, correctIndex: Int) -> Color {
        guard showResult else { return .white.opacity(0.9) }
        if i == correctIndex { return .green.opacity(0.25) }
        if i == selectedIndex { return .red.opacity(0.20) }
        return .white.opacity(0.9)
    }

    private func startNewGame() {
        questions =
            allQuestions
            .shuffled()
            .prefix(10)
            .map { q in
                Question(
                    text: q.text,
                    options: q.options.shuffled(),
                    correctAnswer: q.correctAnswer
                )
            }

        currentIndex = 0
        correctCount = 0
        answeredCount = 0
    }
}

#Preview {
    NavigationStack {
        GameView(path: .constant(NavigationPath()))
            .environmentObject(AppState())
    }
}

