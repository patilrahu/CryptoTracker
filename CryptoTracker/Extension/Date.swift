//
//  Date.swift
//  CryptoTracker
//
//  Created by Apple on 26/10/25.
//

import Foundation

extension Date {
    init(coinGekoString: String) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateformatter.date(from: coinGekoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }
    
    func asShortString() -> String {
        return shortFormatter.string(from: self)
    }
}
