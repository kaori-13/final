//
//  Switch.swift
//  final
//
//  Created by Fanny on 2025/12/16.
//
import SwiftUI

struct SwitchView: View {
    var body: some View {
            NavigationStack {
                VStack(spacing: 10) {
                    Text("單字勤學王")
                        .font(.system(size: 50))
                        .bold()
                    NavigationLink(destination: GameView()) {
                        Text("開始遊戲")
                            .font(.system(size: 40))
                            .padding(30)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    NavigationLink(destination: BarlineView()) {
                        Text("歷史高分")
                            .font(.system(size: 40))
                            .padding(30)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    NavigationLink(destination: UserView()) {
                        Text("設定畫面")
                            .font(.system(size: 40))
                            .padding(30)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        
                    }
                    NavigationLink(destination: GameView()) {
                        Text("領獎活動")
                            .font(.system(size: 40))
                            .padding(30)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                
            }
    }
}
#Preview {
    SwitchView()
}
