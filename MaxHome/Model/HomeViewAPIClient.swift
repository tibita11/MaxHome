//
//  HomeViewAPIClient.swift
//  MaxHome
//
//  Created by 鈴木楓香 on 2024/05/27.
//

import Foundation

protocol HomeViewAPIClientProtocol {
    func fetch() -> [HomeTabModel]
}

class HomeViewAPIClient: HomeViewAPIClientProtocol {
    // サーバーへ接続
    func fetch() -> [HomeTabModel] {
        var tabs: [HomeTabModel] = []
        Tab.allCases.forEach { tab in
            let homeTabModel = HomeTabModel(
                id: tab,
                topBanner: [
                    HomeTopBanner(
                        image: "oshinoko1",
                        description: "地方都市で、産婦人科医として働くゴロー。芸能界とは無縁の日々。一方、彼の推しのアイドル・星野アイは、スターダムを上り始めていた。そんな二人が最悪の出会いを果たし、運命が動き出す…!?"),
                    HomeTopBanner(
                        image: "oshinoko2",
                        description: "推しのアイドル・星野アイの子に転生し、前世の記憶を持ったまま、赤ちゃんライフを満喫する双子のアクアとルビー！ しかし、その時間も束の間に、アイはストーカーに殺害されてしまう…。時が経ち、双子は高校生になると同時に、アクアは復讐のため、ルビーは母親のように輝くため、各々の思惑を胸に芸能界に挑む…！"),
                    HomeTopBanner(
                        image: "oshinoko3",
                        description: "芸能科のある高校に進学した双子の兄妹、アクアとルビー。ルビーは、既に芸能界で活躍する同級生らを目の当たりにし、焦りを感じつつも…アイドル活動の準備を始める!!　一方、アクアはネットドラマ出演時のプロデューサーに誘われ恋愛リアリティショーへ出演する事に。芸能界の“リアル”とは…!?")],
                sections: [
                    HomeSection(
                        title: "For You",
                        images: [
                            "zyuzyutu1",
                            "zyuzyutu2",
                            "zyuzyutu3",
                            "zyuzyutu4",
                            "zyuzyutu5",
                            "zyuzyutu6",
                            "zyuzyutu7",
                            "zyuzyutu8",
                            "zyuzyutu9",
                            "zyuzyutu10",
                        ]),
                    HomeSection(
                        title: "For You",
                        images: [
                            "zyuzyutu1",
                            "zyuzyutu2",
                            "zyuzyutu3",
                            "zyuzyutu4",
                            "zyuzyutu5",
                            "zyuzyutu6",
                            "zyuzyutu7",
                            "zyuzyutu8",
                            "zyuzyutu9",
                            "zyuzyutu10",
                        ])])
            tabs.append(homeTabModel)
        }
        return tabs
    }
}
