//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by Apple on 21/10/25.
//

import Foundation
import Combine
import SwiftUI

class CoinDataService {
    @Published var allCoins:[CoinModel] = []
    var coinCancelllable: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    private func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin&names=Bitcoin&symbols=btc&category=layer-1&price_change_percentage=1h") else { return }
        
        coinCancelllable =  NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: {[weak self] (returedCoins) in
                self?.allCoins = returedCoins
                self?.coinCancelllable?.cancel()
            })
    }
}



