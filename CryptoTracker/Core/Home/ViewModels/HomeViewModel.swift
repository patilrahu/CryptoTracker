//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Apple on 21/10/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var statistics: [StaticsticsModel] = [
        
    ]
    @Published var allCoins:[CoinModel] = []
    @Published var portFolioCoins:[CoinModel] = []
    @Published var searchText: String = ""
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancellable = Set<AnyCancellable>()
    init() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.allCoins.append(DeveloperPreview.instance.coin)
//            self.portFolioCoins.append(DeveloperPreview.instance.coin)
//        }
        addSubscribers()
    }
    
    func addSubscribers() {
//        dataService.$allCoins.sink { [weak self] (coins) in
//            self?.allCoins = coins
//        }.store(in: &cancellable)
        $searchText.combineLatest(coinDataService.$allCoins)
            .map { (text,startingCoins) -> [CoinModel] in
                guard !text.isEmpty else {
                    return startingCoins
                }
                
                let lowerCaseText = text.lowercased()
                return startingCoins.filter {
                    $0.name.lowercased().contains(lowerCaseText) || $0.symbol.lowercased().contains(lowerCaseText) || $0.id.lowercased().contains(lowerCaseText)
                }
                
            }.debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }.store(in: &cancellable)
        marketDataService.$marketData.map { (marketDataModel) -> [StaticsticsModel] in
            var stats: [StaticsticsModel] = []
            guard let data = marketDataModel else {
                return stats
            }
            let marketCap = StaticsticsModel(title: "Market Cap", value: data.marketCap, percentage: data.marketCapChangePercentage24HUsd)
            let volume = StaticsticsModel(title: "24h Volume", value: data.volume)
            let btcDominance = StaticsticsModel(title: "BTC Dominance", value: data.btcDominance)
            let portFolioValue = StaticsticsModel(title: "Portfolio Value", value: "$0.00",percentage: 0)
            stats.append(contentsOf: [
                marketCap,
                volume,
                btcDominance,
                portFolioValue
            ])
            return stats
        }.sink { [weak self] (returnedStats) in
            self?.statistics = returnedStats
        }.store(in: &cancellable)
    }
    
    
    
}
