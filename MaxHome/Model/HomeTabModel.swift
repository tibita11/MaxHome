//
//  HomeTabModel.swift
//  MaxHome
//
//  Created by 鈴木楓香 on 2024/05/27.
//

import Foundation

enum Tab: String, CaseIterable {
    case home = "Home"
    case series = "Series"
    case movies = "Movies"
    case new = "New"
    case anime = "Anime"
    case kids = "Kids"
    case live = "Live"
}

struct HomeTabModel {
    let id: Tab
    let topBanner: [HomeTopBanner]
    let sections: [HomeSection]
}

struct HomeTopBanner {
    let id = UUID().uuidString
    let image: String
    let description: String
}

struct HomeSection {
    let id = UUID().uuidString
    let title: String
    let images: [String]
}
