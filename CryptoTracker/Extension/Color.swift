//
//  Color.swift
//  CryptoTracker
//
//  Created by Apple on 20/10/25.
//

import Foundation
import SwiftUICore


extension Color {
    static let theme = ColorTheme()
}


struct ColorTheme {
    let accentColor =  Color("AccentColor")
    let backgroundColor =  Color("BackgroundColor")
    let greenColor =  Color("GreenColor")
    let redColor =  Color("RedColor")
    let secondaryTextColor =  Color("SecondaryTextColor")
}
