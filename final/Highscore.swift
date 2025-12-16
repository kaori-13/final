import SwiftUI


struct HighscoreView: View {
    var body: some View {
        ZStack {
            Color.blue.opacity(0.1).ignoresSafeArea() // 背景色
            VStack {
                Text("歷史得分")
                    .font(.largeTitle)
                    .padding()
                Text("您是從第一個畫面導航過來的。")
            }
        }
        .navigationTitle("下一個") // 設定第二個畫面頂部的標題
    }
}

#Preview {
    HighscoreView()
}

