//
//  SwitchView.swift
//  final
//
//  Created by Fanny on 2025/12/16.
//
import SwiftUI

enum AppRoute: Hashable {
    case game
    case score
    case user
    case prize
}

struct SwitchView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 10) {
                Text("單字勤學王")
                    .font(.system(size: 50))
                    .bold()

                NavigationLink(value: AppRoute.game) {
                    MainButton(title: "開始遊戲")
                }

                NavigationLink(value: AppRoute.score) {
                    MainButton(title: "歷史高分")
                }

                NavigationLink(value: AppRoute.user) {
                    MainButton(title: "設定畫面")
                }

                NavigationLink(value: AppRoute.prize) {
                    MainButton(title: "領獎活動")
                }
            }
            .padding()
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .game:
                    GameView(path: $path)
                case .score:
                    BarlineView()
                case .user:
                    UserView()
                case .prize:
                    // 先暫時導到 GameView，你也可以換成 PrizeView()
                    GameView(path: $path)
                }
            }
        }
    }
}

struct MainButton: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.system(size: 40))
            .padding(30)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

#Preview {
    SwitchView()
        .environmentObject(AppState())
}

#Preview {
    SwitchView()
        .environmentObject(AppState())
}

