//
//  TabRectKey.swift
//  MaxHome
//
//  Created by 鈴木楓香 on 2024/05/10.
//

import SwiftUI

struct TabRectKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func tabRect(completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader { proxy in
                    let rect = proxy.frame(in: .named("ScrollTab"))
                    Color.clear
                        .preference(key: TabRectKey.self, value: rect)
                        .onPreferenceChange(TabRectKey.self, perform: completion)
                }
            }
    }
}
