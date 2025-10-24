//
//  MarketDataService.swift
//  CryptoTracker
//
//  Created by Apple on 23/10/25.
//

import Foundation
import Combine


class MarketDataService {
    @Published var marketData:MarketDataModel? = nil
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    private func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubscription =  NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: {[weak self] (returedCoins) in
                self?.marketData = returedCoins.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
