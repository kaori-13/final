import SwiftUI
import Foundation



import SwiftUI

// MARK: - 1. 數據模型 (包含圖片名稱)

struct Player: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String // 儲存自定義圖片在 Assets.xcassets 中的名稱
}

struct UserView: View {
    
    // 1. 定義所有玩家數據的列表 (使用自定義圖片名稱)
    // *** 注意：您必須確保您的 Assets.xcassets 裡有這些圖片 (player_ming, player_wang, etc.) ***
    let playersData: [Player] = [
        Player(name: "梵谷", imageName: "vangogh"),
        Player(name: "達利", imageName: "dali"),
        Player(name: "安迪", imageName: "Andy"),
        Player(name: "莫內", imageName: "Monet"),
        Player(name: "卡索", imageName: "Picasso")
    ]
    
    // 2. 使用 @State 儲存「當前被開啟的玩家索引」
    @State private var activePlayerIndex: Int? = nil
    
    // 確定當前被選中的玩家名稱
    var selectedPlayerName: String {
        if let index = activePlayerIndex, index >= 0 && index < playersData.count {
            return playersData[index].name
        }
        return "無人選中"
    }

    var body: some View {
        VStack (spacing: 20){
            
            // 顯示當前被選中的玩家
            Text("當前啟用的玩家：\(selectedPlayerName)")
                .font(.title)
                .bold()
                .padding(.bottom, 20)
            
            // 遍歷所有玩家來生成 Toggle
            ForEach(playersData.indices, id: \.self) { index in
                HStack {
                    let player = playersData[index]
                    
                    // === [自定義圖片頭像部分] ===
                    // 使用 Image(player.imageName) 載入自定義圖片
                    Image(player.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill) // 確保圖片填滿圓形
                        .frame(width: 50, height: 50) // 設置頭像大小
                        .clipShape(Circle()) // 裁剪成圓形
                        .overlay(
                            Circle()
                                .stroke(activePlayerIndex == index ? Color.green : Color.gray,
                                        lineWidth: activePlayerIndex == index ? 3 : 1) // 被選中時邊框變粗/變色
                        )
                    // ==============================

                    // 玩家名稱
                    Text(player.name)
                        .font(.largeTitle)
                        .bold()
                        .frame(width: 80, alignment: .leading)
                    
                    Spacer()
                    
                    // 3. 使用自定義的 Toggle 動作實現單選
                    Toggle("", isOn: Binding(
                        get: { activePlayerIndex == index },
                        set: { newValue in
                            if newValue {
                                activePlayerIndex = index
                            } else {
                                if activePlayerIndex == index {
                                    activePlayerIndex = nil
                                }
                            }
                        }
                    ))
                    .labelsHidden()
                    .toggleStyle(.switch)
                }
                .padding(.horizontal, 40)
            }
        }
    }
}

// 預覽需要運行時有圖片，但為了方便測試，我們使用一個通用預覽
#Preview {
    UserView()
}

#Preview {
    UserView()
}

#Preview {
    UserView()
}
