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
