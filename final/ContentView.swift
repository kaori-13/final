//
//  ContentView.swift
//  final
//
//  Created by Fanny on 2025/12/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
//            Image(.sunflowers)
//                .resizable()
//                .scaledToFill()
            VStack {
                Text("單字勤學王")
                    .font(.system(size: 50))
                    .bold()
                SwitchView()
            }
        }
    }
}

#Preview {
    ContentView()
}
