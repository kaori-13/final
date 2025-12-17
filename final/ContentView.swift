//
//  ContentView.swift
//  final
//
//  Created by Fanny on 2025/12/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Homepage", systemImage: "house.circle.fill") {
                IntroView()
            }
            Tab("Intro", systemImage: "person.circle.fill") {
                SwitchView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
