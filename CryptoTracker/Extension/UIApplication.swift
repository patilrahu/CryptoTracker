//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by Apple on 23/10/25.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
