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
        currentHoldings: 1.5
    )

}



