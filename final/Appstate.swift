//
//  Appstate.swift
//  final
//
//  Created by Fanny on 2025/12/16.
//

import SwiftUI
import Combine 

final class AppState: ObservableObject {
    @Published var activePlayerName: String = "梵谷"

    @Published var highScores: [String: Int] = [:] {
        didSet { saveScores() }
    }

    private let storageKey = "HIGH_SCORES_V1"

    init() {
        loadScores()
    }

    func updateHighScore(player: String, newScore: Int) {
        let old = highScores[player] ?? 0
        if newScore > old {
            highScores[player] = newScore
        }
    }

    private func saveScores() {
        if let data = try? JSONEncoder().encode(highScores) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }

    private func loadScores() {
        guard
            let data = UserDefaults.standard.data(forKey: storageKey),
            let dict = try? JSONDecoder().decode([String: Int].self, from: data)
        else { return }
        highScores = dict
    }
}
