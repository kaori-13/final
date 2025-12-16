//
//  ContentView.swift
//  final
//
//  Created by Fanny on 2025/12/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack {
                SwitchView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
