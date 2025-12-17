//
//  Intro.swift
//  final
//
//  Created by Fanny on 2025/12/17.
//
import SwiftUI

struct IntroView: View {
    var body: some View {
        ZStack {
            Image(.bgm)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            Text(
                "「單字勤學王」是一款四選一英文填空遊戲，透過答題累積分數，輕鬆提升單字實力。"
            )
            .bold()
            .font(.largeTitle)
            .multilineTextAlignment(.leading)   // 左對齊（可選）
            .frame(maxWidth: 300)          // ✅ 關鍵：限制寬度
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
            )
            
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.8))
                
            )
            .opacity(0.5)
        }
    }
}

#Preview {
    IntroView()
}
