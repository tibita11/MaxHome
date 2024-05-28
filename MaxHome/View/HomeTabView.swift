//
//  HomeTabView.swift
//  MaxHome
//
//  Created by 鈴木楓香 on 2024/05/11.
//

import SwiftUI

struct HomeTabView: View {
    var tab: HomeTabModel
    @State private var dragOffset: CGFloat = 0
    @State private var topBannerActivePage: Int = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 30) {
                VStack(spacing: 15) {
                    headerView()
                    indicator()
                }
                
                VStack(spacing: 30) {
                    ForEach(tab.sections, id: \.id) { section in
                        sectionView(title: section.title, images: section.images)
                    }
                }
            }
        }
        .padding(.bottom, 20)
    }
    
    @ViewBuilder
    private func headerView() -> some View {
        GeometryReader { proxy in
            HStack(spacing: 0) {
                ForEach(tab.topBanner, id: \.id) { topBanner in
                    VStack {
                        Image(topBanner.image)
                            .resizable()
                            .frame(height: proxy.size.height * 0.9)
                            .overlay {
                                Rectangle()
                                    .fill(.linearGradient(colors: [
                                        .black.opacity(0.8),
                                        .black.opacity(0.4),
                                        .black.opacity(-0.1),
                                        .black.opacity(-0.5),
                                        .black.opacity(-0.3),
                                        .black.opacity(-0.1),
                                        .black.opacity(1),
                                    ], startPoint: .top, endPoint: .bottom))
                            }
                        
                        Text(topBanner.description)
                            .padding(.horizontal, 15)
                            .font(.caption2)
                    }
                    .frame(width: proxy.size.width)
                }
            }
            .offset(x: dragOffset)
            .offset(x: -CGFloat(topBannerActivePage) * proxy.size.width)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        print("test onChanged: \(value)")
                        if topBannerActivePage == 0,
                           value.translation.width > 0 {
                            dragOffset = value.translation.width / 5
                        } else if topBannerActivePage == tab.topBanner.count - 1,
                                  value.translation.width < 0 {
                            dragOffset = value.translation.width / 5
                        } else {
                            dragOffset = value.translation.width
                        }
                    }
                    .onEnded { value in
                        print("test onEnded: \(value)")
                        var nextIndex = topBannerActivePage
                        let translationWidth = value.translation.width
                        guard abs(translationWidth) > proxy.size.width * 0.3 else {
                            return
                        }
                        
                        if translationWidth < 0,
                           topBannerActivePage != tab.topBanner.count - 1 {
                            nextIndex += 1
                        }
                        
                        if translationWidth > 0,
                           topBannerActivePage != 0 {
                            nextIndex -= 1
                        }
                        
                        withAnimation {
                            dragOffset = 0
                            topBannerActivePage = nextIndex
                        }
                    }
            )
        }
        .frame(height: 500)
    }
    
    @ViewBuilder
    private func indicator() -> some View {
        HStack {
            ForEach(tab.topBanner.indices, id: \.self) { num in
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(num == topBannerActivePage ? .white : .gray)
            }
        }
    }
    
    @ViewBuilder
    private func sectionView(title: String, images: [String]) -> some View {
        GeometryReader { proxy in
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(images, id: \.self) { image in
                            Image(image)
                                .resizable()
                                .aspectRatio(9 / 16, contentMode: .fill)
                        }
                    }
                }
            }
            .padding(.leading, 15)
        }
        .frame(height: 250)
    }
}

#Preview {
    HomeTabView(tab: HomeViewAPIClient().fetch()[0])
        .preferredColorScheme(.dark)
}
