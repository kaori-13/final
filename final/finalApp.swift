//
//  finalApp.swift
//  final
//
//  Created by Fanny on 2025/12/16.
//

import SwiftUI

@main
struct finalApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AppState())
        }
    }
}

var wrongHistory: [WrongRecord] = []

func addWrongRecord(question: String, correct: String, selected: String) {
    let record = WrongRecord(
        question: question,
        correctAnswer: correct,
        selectedAnswer: selected,
        date: Date()
    )
    wrongHistory.insert(record, at: 0)
}
