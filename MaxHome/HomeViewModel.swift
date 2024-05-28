//
//  TabModel.swift
//  MaxHome
//
//  Created by 鈴木楓香 on 2024/05/10.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published private(set) var tabs: [HomeTabModel] = []
    private var homeViewAPIClient: HomeViewAPIClientProtocol
    // tabの長さと幅の情報を保持
    @Published var tabMetrics: [(minX: CGFloat, width: CGFloat)] = []
    @Published var activeTab: Tab = .home
    
    init(homeViewAPIClient: HomeViewAPIClientProtocol) {
        self.homeViewAPIClient = homeViewAPIClient
        self.tabs = homeViewAPIClient.fetch()
        self.tabMetrics = getTabMetrics()
    }
    
    private func getTabMetrics() -> [(minX: CGFloat, width: CGFloat)] {
        var tabMetrics: [(minX: CGFloat, width: CGFloat)] = []
        self.tabs.forEach { _ in
            tabMetrics.append((.zero, .zero))
        }
        return tabMetrics
    }
    
    func getActiveTabIndex() -> Int {
        tabs.firstIndex(where: { $0.id == activeTab }) ?? 0
    }
}
