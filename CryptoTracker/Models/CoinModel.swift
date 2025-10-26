//
//  CoinModel.swift
//  CryptoTracker
//
//  Created by Apple on 20/10/25.
//

import Foundation

/*
 
 URL - https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin&names=Bitcoin&symbols=btc&category=layer-1&price_change_percentage=1h
 
 JSon Response - [
 {
   "id": "bitcoin",
   "symbol": "btc",
   "name": "Bitcoin",
   "image": "<https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400>",
   "current_price": 70187,
   "market_cap": 1381651251183,
   "market_cap_rank": 1,
   "fully_diluted_valuation": 1474623675796,
   "total_volume": 20154184933,
   "high_24h": 70215,
   "low_24h": 68060,
   "price_change_24h": 2126.88,
   "price_change_percentage_24h": 3.12502,
   "market_cap_change_24h": 44287678051,
   "market_cap_change_percentage_24h": 3.31157,
   "circulating_supply": 19675987,
   "total_supply": 21000000,
   "max_supply": 21000000,
   "ath": 73738,
   "ath_change_percentage": -4.77063,
   "ath_date": "2024-03-14T07:10:36.635Z",
   "atl": 67.81,
   "atl_change_percentage": 103455.83335,
   "atl_date": "2013-07-06T00:00:00.000Z",
   "roi": null,
   "last_updated": "2024-04-07T16:49:31.736Z"
 }
]
 */
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let coinModel = try? JSONDecoder().decode(CoinModel.self, from: jsonData)

import Foundation

// MARK: - CoinModelElement
struct CoinModel: Codable,Identifiable {
    let id, symbol, name, image: String
    let currentPrice: Double
    let  marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let currentHoldings: Double?
    let sparkline_in_7d: SparkLineIn7D?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case  marketCapRank = "market_cap_rank"
        case marketCap, fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume, high24H, low24H
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply, totalSupply, maxSupply, ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl, atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case currentHoldings,sparkline_in_7d

    }
    
    func updateHoldings(amount: Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, currentHoldings: amount, sparkline_in_7d: sparkline_in_7d)
    }
    
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
}

struct SparkLineIn7D: Codable {
    let price:[Double]?
}

