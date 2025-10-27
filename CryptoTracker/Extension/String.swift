//
//  String.swift
//  CryptoTracker
//
//  Created by Apple on 27/10/25.
//

import Foundation


extension String {
    var removeHTMLoccurrences: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
