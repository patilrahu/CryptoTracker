//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Apple on 20/10/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    @State private var showSheet: Bool = false
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
                .sheet(isPresented: $showSheet) {
                    PortfolioView().environmentObject(vm)
                }
               
            
            VStack {
                HomeHeader
                HomeStatsView(showPortFolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                holdingView
                if !showPortfolio {
                    allCoinBody
                    .transition(.move(edge: .leading))
                }
                if showPortfolio {
                    portfolioCoinBody
                        .transition(.move(edge: .trailing))
                }
               
                
                Spacer(minLength: 0)
            }
        }
    }
}


struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }.environmentObject(dev.homeVM)
    }
}



extension HomeView {
    private var HomeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    if (showPortfolio) {
                        showSheet.toggle()
                    }
                }
                .background(CircleButtonAnimationView(isAnimating: $showPortfolio))
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accentColor)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring) {
                        showPortfolio.toggle()
                    }
                }
        }.padding(.horizontal)
    }
    
    private var allCoinBody: some View {
        List {
            ForEach(vm.allCoins) { coinData in
                CoinRowView(coin: coinData, showHoldingColumn: false).listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
            
        }
        .listStyle(PlainListStyle())
        
        
    }
    
    private var portfolioCoinBody: some View {
        List {
            ForEach(vm.portFolioCoins) { coinData in
                CoinRowView(coin: coinData, showHoldingColumn: true).listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
            
        }
        .listStyle(PlainListStyle())
    }
    
    
    private var holdingView: some View {
        HStack {
            Text("Coins")
            Spacer()
            if (showPortfolio) {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryTextColor)
        .padding(.horizontal)
    }
}
