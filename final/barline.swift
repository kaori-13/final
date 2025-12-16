import Charts
import FoundationModels
import Playgrounds
import SwiftUI

//struct barline2View: View {
//    var body: some View {
//        VStack {
//
//            BarlineView()
//            BarlineView()
//        }
//    }
//}

struct BarlineView: View {
    let scores: [Scorecollect] = [
        Scorecollect(name: "小明", score: "500"),
        Scorecollect(name: "小花", score: "800"),
        Scorecollect(name: "小羊", score: "350"),
        Scorecollect(name: "小虎", score: "620"),
        Scorecollect(name: "小小", score: "900"),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {

            Text("📊 玩家歷史高分")
                .font(.title2)
                .padding(.horizontal)
                .padding(.top)

            // 調整 Chart 區域以容納所有玩家的水平長條圖
            Chart {
                // 遍歷所有得分記錄
                // id: \.id 使用 Scorecollect 中定義的 UUID
                ForEach(scores) { score in

                    // 由於您的分數是 String 類型，我們需要在使用時將其轉換為 Int
                    let scoreValue = Int(score.score) ?? 0  // 如果轉換失敗，則設為 0

                    BarMark(
                        // X 軸 (數值)：分數
                        x: .value("數值", scoreValue),
                        // Y 軸 (類別)：玩家名稱
                        y: .value("玩家", score.name)
                    )
                    .foregroundStyle(by: .value("玩家", score.name))  // 讓每個玩家有不同顏色

                    // 在長條圖末端顯示數值
                    .annotation(position: .trailing) {
                        Text(score.score)  // 直接顯示原始的 String 分數
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .frame(height: 250)
            .padding(.horizontal)

            Divider()

            //            if let firstPlayer = scores.first {
            //                HStack(spacing: 15) {
            //
            //                    Image(systemName: "person.circle.fill")
            //                        .resizable()
            //                        .frame(width: 45, height: 45)
            //                        .clipShape(Circle())
            //
            //                    Text(firstPlayer.name)
            //                        .font(.system(size: 20))
            //
            //                    Spacer()
            //                    Text("得分: \(firstPlayer.score)")
            //                        .font(.headline)
            //                        .foregroundStyle(.purple)
            //                }
            //                .padding(.horizontal)
            //            }
        }
    }
}

#Preview {
    BarlineView()
}

//#Preview {
//    barline2View()
//}
