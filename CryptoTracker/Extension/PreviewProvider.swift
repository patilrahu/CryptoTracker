//
//  PreviewProvider.swift
//  CryptoTracker
//
//  Created by Apple on 20/10/25.
//

import Foundation
import SwiftUI


extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}


class DeveloperPreview {
    static let instance = DeveloperPreview()
    let homeVM = HomeViewModel()
    let stat1VM = StaticsticsModel(title: "Market Cap", value: "$14.03Bn", percentage: 25)
    let stat2VM = StaticsticsModel(title: "Total Volume", value: "$12.09Tr")
    let stat3VM = StaticsticsModel(title: "Portfolio Value", value: "$50.4k",percentage: -12.34)
    private init() {
        
    }
    let coin = CoinModel(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png",
        currentPrice: 67000.0,
        marketCap: 1300000000000,
        marketCapRank: 1,
        fullyDilutedValuation: 1400000000000,
        totalVolume: 25000000000,
        high24H: 68000.0,
        low24H: 66000.0,
        priceChange24H: -500.0,
        priceChangePercentage24H: -0.75,
        marketCapChange24H: -10000000000,
        marketCapChangePercentage24H: -0.8,
        circulatingSupply: 19500000,
        totalSupply: 21000000,
        maxSupply: 21000000,
        ath: 69000.0,
        athChangePercentage: -2.9,
        athDate: "2021-11-10T00:00:00.000Z",
        atl: 67.81,
        atlChangePercentage: 98500.0,
        atlDate: "2013-07-06T00:00:00.000Z",
        lastUpdated: "2025-10-20T12:00:00.000Z",
        currentHoldings: 1.5,
        sparkline_in_7d: SparkLineIn7D(price: [
            107577.25, 108220.30, 108845.57, 109107.98, 110412.00,
            110908.40, 111295.59, 111180.73, 110990.27, 111059.96,
            111308.87, 111506.05, 110926.43, 111121.54, 110647.09,
            110852.97, 110603.83, 110577.91, 110042.55, 109572.58,
            109306.52, 108559.48, 108547.64, 109143.62, 108359.85,
            110783.79, 113332.12, 112412.75, 111923.68, 111977.46
        ])
    )

}



