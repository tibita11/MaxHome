//
//  ContentView.swift
//  MaxHome
//
//  Created by 鈴木楓香 on 2024/05/10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
            .ignoresSafeArea()
            .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
