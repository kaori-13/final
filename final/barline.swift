import Charts
import FoundationModels
import Playgrounds
import SwiftUI

struct BarlineChartView: View {
    @EnvironmentObject var appState: AppState

    private var scores: [Scorecollect] {
        let arr = appState.highScores.map { (key, value) in
            Scorecollect(name: key, score: value)
        }
        return arr.sorted { $0.score > $1.score }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("📊 玩家歷史高分")
                .font(.title2)
                .padding(.horizontal)
                .padding(.top)

            Text("目前選擇的玩家：\(appState.activePlayerName)")
                .font(.headline)
                .padding(.horizontal)
                .foregroundStyle(.secondary)

            Chart {
                ForEach(scores) { s in
                    BarMark(
                        x: .value("分數", s.score),
                        y: .value("玩家", s.name)
                    )
                    .annotation(position: .trailing) {
                        Text("\(s.score)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .frame(height: max(250, CGFloat(scores.count) * 40))
            .padding(.horizontal)

            Divider()
        }
    }
}



#Preview {
    BarlineChartView()
        .environmentObject(AppState())
}



