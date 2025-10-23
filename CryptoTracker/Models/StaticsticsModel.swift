//
//  StaticsticsModel.swift
//  CryptoTracker
//
//  Created by Apple on 23/10/25.
//

import Foundation

struct StaticsticsModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentage: Double?
    
    init(title: String, value: String, percentage: Double? = nil) {
        self.title = title
        self.value = value
        self.percentage = percentage
    }
}
