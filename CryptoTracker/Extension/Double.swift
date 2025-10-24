//
//  Double.swift
//  CryptoTracker
//
//  Created by Apple on 20/10/25.
//

import Foundation

extension Double {
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current
//        formatter.currencyCode = "usd"
//        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    func asCurrencyWith6Decimals() -> String {
        return currencyFormatter6.string(from: NSNumber(value: self)) ?? "$0.00"
    }
    
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    func asPercentageString() -> String {
        return asNumberString() + "%"
    }
    
    func formatNumber() -> String {
        let num = abs(Double(self))
        let sign = num < 0 ? "-" : ""
        switch num {
        case 1_000_000_000_000...:
            return "\(sign)\(String(format: "%.1f", num / 1_000_000_000_000))Tr"
        case 1_000_000_000...:
            return "\(sign)\(String(format: "%.1f", num / 1_000_000_000))Bn"
        case 1_000_000...:
            return "\(sign)\(String(format: "%.1f", num / 1_000_000))M"
        case 1_000...:
            return "\(sign)\(String(format: "%.1f", num / 1_000))K"
        default:
            return "\(sign)\(Int(num))"
        }
    }

}
