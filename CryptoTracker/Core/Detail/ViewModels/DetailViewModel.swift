//
//  DetailViewModel.swift
//  CryptoTracker
//
//  Created by Apple on 26/10/25.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    @Published var overViewStaticstics: [StaticsticsModel] = []
    @Published var additionlaStaticstics: [StaticsticsModel] = []
    @Published var description: String? = nil
    @Published var websiteUrl: String? = nil
    @Published var redditUrl: String? = nil
    private let coinDetailService: CoinDeatilDataService
    @Published var coin: CoinModel
    private var cancellables =  Set<AnyCancellable>()
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDeatilDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map({ (coinDetailModel,coinModel) -> (overview:[StaticsticsModel], additionals:[StaticsticsModel]) in
                
                let price = coinModel.currentPrice.asCurrencyWith6Decimals()
                let priceChange = coinModel.priceChangePercentage24H
                let priceStats = StaticsticsModel(title: "Current Price", value: price, percentage: priceChange)
                
                let marketCap = "$" + (coinModel.marketCap?.formatNumber() ?? "")
                let marketCapChange24hr = coinModel.marketCapChangePercentage24H
                let marketCapStats = StaticsticsModel(title: "Market Cap", value: marketCap, percentage: marketCapChange24hr)
                let rank = "\(coinModel.rank)"
                let rankStat = StaticsticsModel(title: "Rank", value: rank)
                let volume = "$" + (coinModel.totalVolume?.formatNumber() ?? "")
                let volumeStat = StaticsticsModel(title: "Volume", value: volume)
                let overviewArray: [StaticsticsModel] = [
                    priceStats,marketCapStats,rankStat,volumeStat
                ]
                
                let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
                let highStat = StaticsticsModel(title: "High 24h", value: high)
                let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
                let lowStat = StaticsticsModel(title: "Low 24h", value: low)
                let priceChangePercent = coinModel.priceChangePercentage24H?.asCurrencyWith6Decimals() ?? "n/a"
                let priceChangePercent2 = coinModel.priceChangePercentage24H
                let priceChangeStat = StaticsticsModel(title: "Price Change 24h", value: priceChangePercent,percentage: priceChangePercent2)
                let marketCapChangePercent = coinModel.marketCapChangePercentage24H?.asCurrencyWith6Decimals() ?? "n/a"
                let marketCapChangePercent2 = coinModel.marketCapChangePercentage24H
                let marketCapChangeStat = StaticsticsModel(title: "Market Cap Change 24h", value: marketCapChangePercent,percentage: marketCapChangePercent2)
                let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
                let blockTimeStat = StaticsticsModel(title: "Block Time", value: "\(blockTime) min")
                let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
                let hashingStat = StaticsticsModel(title: "Hashing Algorithm", value: hashing)
                let additionalsArray: [StaticsticsModel] = [
                    highStat,lowStat,priceChangeStat,marketCapChangeStat,blockTimeStat,hashingStat
                ]
                
                return (overviewArray,additionalsArray)
            })
            .sink { [weak self] (returendArray) in
                self?.overViewStaticstics = returendArray.overview
                self?.additionlaStaticstics = returendArray.additionals
        }.store(in: &cancellables)
        
        
        coinDetailService.$coinDetails.sink { [weak self] (returnedCoinDetail) in
            self?.description = returnedCoinDetail?.description?.en?.removeHTMLoccurrences
            self?.websiteUrl = returnedCoinDetail?.links?.homepage?.first
            self?.redditUrl = returnedCoinDetail?.links?.subredditURL
        }.store(in: &cancellables)
    }
}
