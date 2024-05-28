//
//  Home.swift
//  MaxHome
//
//  Created by 鈴木楓香 on 2024/05/10.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel = {
        HomeViewModel(homeViewAPIClient: HomeViewAPIClient())
    }()

    var body: some View {
        ScrollViewReader { proxy in
            ZStack(alignment: .top) {
                tabView(scrollProxy: proxy)
                VStack(spacing: 0) {
                    header()
                        .padding(.top, 30)
                    scrollTab(scrollProxy: proxy)
                }
            }
        }
    }
    
    @ViewBuilder
    private func header() -> some View {
        HStack(spacing: 0) {
            Image(.maxLogo)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
            Spacer()
            Button(action: {
                
            }, label: {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
            })
        }
        .frame(height: 20)
        .padding(.top, 15)
        .padding(.horizontal, 30)
    }
    
    @ViewBuilder
    private func scrollTab(scrollProxy: ScrollViewProxy) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.tabs.indices, id: \.self) { index in
                    Button(action: {
                        withAnimation {
                            viewModel.activeTab = viewModel.tabs[index].id
                            scrollProxy.scrollTo(viewModel.tabs[index].id, anchor: .center)
                        }
                    }, label: {
                        Text(viewModel.tabs[index].id.rawValue)
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundColor(viewModel.tabs[index].id == viewModel.activeTab ? .white : .gray)
                            .clipShape(.rect)
                    })
                    .tabRect { rect in
                        viewModel.tabMetrics[index].minX = rect.minX
                        viewModel.tabMetrics[index].width = rect.width
                    }
                    .id(viewModel.tabs[index].id)
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 15)
            }
        }
        .coordinateSpace(name: "ScrollTab")
        .overlay(alignment: .bottomLeading, content: {
            Rectangle()
                .frame(width: viewModel.tabMetrics[viewModel.getActiveTabIndex()].width,
                       height: 1)
                .offset(x: viewModel.tabMetrics[viewModel.getActiveTabIndex()].minX)
        })
        .padding(.horizontal, 20)
        .padding(.top, 15)
    }
    
    @ViewBuilder
    private func tabView(scrollProxy: ScrollViewProxy) -> some View {
        TabView(selection: Binding<Tab>(
            get: {
                viewModel.activeTab
            },
            set: { value in
                withAnimation {
                    viewModel.activeTab = value
                    scrollProxy.scrollTo(value, anchor: .center)
                }
            })) {
                ForEach(viewModel.tabs, id: \.id) { tab in
                    HomeTabView(tab: tab)
                        .ignoresSafeArea()
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

#Preview {
    ContentView()
}
