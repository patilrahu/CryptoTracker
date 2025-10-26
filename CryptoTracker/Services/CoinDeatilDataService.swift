//
//  CoinDeatilDataService.swift
//  CryptoTracker
//
//  Created by Apple on 26/10/25.
//

import Foundation
import Combine

class CoinDeatilDataService {
    @Published var coinDetails: CoinDetailModel? = nil
    var coinDetailCancelllable: AnyCancellable?
    let coin: CoinModel
    init(coin: CoinModel) {
        self.coin = coin
        getCoinsDetail()
    }
    
    private func getCoinsDetail() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        coinDetailCancelllable =  NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: {[weak self] (returedCoinsDetail) in
                self?.coinDetails = returedCoinsDetail
                self?.coinDetailCancelllable?.cancel()
            })
    }
}
