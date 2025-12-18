//
//  ContentView.swift
//  final
//
//  Created by Fanny on 2025/12/16.
//

import SwiftUI

struct ContentView: View {
    @State private var showWrongAnimation = false

    var body: some View {
        ZStack {
            TabView {
                Tab("Homepage", systemImage: "house.circle.fill") {
                    IntroView()
                }
                Tab("Intro", systemImage: "person.circle.fill") {
                    SwitchView()
                }
            }
            .toolbar {
                // Demo trigger: tap this to simulate a wrong answer
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showWrongAnimation = true
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                    .accessibilityLabel("Show wrong animation")
                }
            }

            // Overlay for wrong answer animation
            WrongAnswerOverlay(isPresented: $showWrongAnimation)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
