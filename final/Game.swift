//
//  Game.swift
//  final
//
//  Created by Fanny on 2025/12/16.
//

import SwiftUI

import SwiftUI

struct GameView: View {
    @EnvironmentObject var appState: AppState
    @Binding var path: NavigationPath

    struct Question {
        let text: String
        let options: [String]
        let correctIndex: Int
    }

    // ✅ 題庫（剛好 10 題）
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
            text: "She decided to ___ the offer after careful consideration.",
            options: ["accept", "accepts", "accepted", "accepting"],
            correctIndex: 0
        ),
        .init(
            text: "The manager will ___ the proposal tomorrow.",
            options: ["review", "reviews", "reviewed", "reviewing"],
            correctIndex: 0
        ),
        .init(
            text: "Please ___ your seat belt during the flight.",
            options: ["fasten", "fastens", "fastened", "fastening"],
            correctIndex: 0
        ),
        .init(
            text: "They will ___ the meeting until next week.",
            options: ["postpone", "postpones", "postponed", "postponing"],
            correctIndex: 0
        ),
        .init(
            text: "We should ___ attention to the details.",
            options: ["pay", "give", "take", "make"],
            correctIndex: 0
        ),
        .init(
            text: "He tried to ___ the issue with his teammate.",
            options: ["discuss", "discussion", "discussed", "discussing"],
            correctIndex: 0
        ),
        .init(
            text: "The company plans to ___ new products next month.",
            options: ["launch", "launched", "launches", "launching"],
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
            // 答對：很快換下一題
            Task { @MainActor in
                try? await Task.sleep(nanoseconds: 250_000_000) // 0.25 秒
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
            appState.updateHighScore(player: appState.activePlayerName, newScore: score)

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
        ["A", "B", "C", "D"][index]
    }

    private func optionBackground(i: Int, correctIndex: Int) -> Color {
        guard showResult else { return .white.opacity(0.9) }
        if i == correctIndex { return .green.opacity(0.25) }
        if i == selectedIndex { return .red.opacity(0.20) }
        return .white.opacity(0.9)
    }
}



#Preview {
    NavigationStack {
        GameView(path: .constant(NavigationPath()))
            .environmentObject(AppState())
    }
}

