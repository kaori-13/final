//
//  Game.swift
//  final
//
//  Created by Fanny on 2025/12/16.
//

import SwiftUI

struct GameView: View {
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.1).ignoresSafeArea() // 背景色
            VStack {
                Text("The project team must ___ the deadline for the final report.")
                    .font(.largeTitle)
                    .padding()
                Text("A: meet")
                    .padding()
                Text("B: reach")
                    .padding()
                Text("C: contact")
                    .padding()
                Text("D: arrive")
                    .padding()
            }
        }
        .navigationTitle("下一個") // 設定第二個畫面頂部的標題
    }
}

#Preview {
    GameView()
}
