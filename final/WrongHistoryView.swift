//
//  WrongHistoryView.swift
//  final
//
//  Created by Fanny on 2025/12/17.
//

import SwiftUI

struct WrongHistoryView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        List(appState.wrongHistory) { r in
            VStack(alignment: .leading, spacing: 6) {
                Text(r.question).font(.headline)
                Text("你的答案：\(r.selectedAnswer)").foregroundStyle(.red)
                Text("正確答案：\(r.correctAnswer)").foregroundStyle(.green)
                Text(r.date, style: .date).font(.caption).foregroundStyle(.secondary)
            }
            .padding(.vertical, 6)
        }
        .navigationTitle("歷史錯題")
    }
}
