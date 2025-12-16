//
//  BarlineView.swift
//  final
//
//  Created by Fanny on 2025/12/16.
//


import SwiftUI
import Charts

struct BarlineView2: View {
    @EnvironmentObject var appState: AppState

    var scores: [Scorecollect] {
        appState.highScores
            .map { Scorecollect(name: $0.key, score: $0.value) }
            .sorted { $0.score > $1.score } // 由高到低
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {

            Text("📊 玩家歷史高分")
                .font(.title2)
                .padding(.horizontal)
                .padding(.top)

            Chart {
                ForEach(scores) { score in
                    BarMark(
                        x: .value("數值", score.score),
                        y: .value("玩家", score.name)
                    )
                    .foregroundStyle(by: .value("玩家", score.name))
                    .annotation(position: .trailing) {
                        Text("\(score.score)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .frame(height: max(250, CGFloat(scores.count) * 40)) // 人多就自動變高
            .padding(.horizontal)

            Divider()
        }
    }
}
