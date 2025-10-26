//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by Apple on 20/10/25.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    let showHoldingColumn:Bool
    var body: some View {
        HStack {
            leftColumn
            Spacer()
            if (showHoldingColumn) {
                middleColumn
            }
            trailingColumn
        }.font(.subheadline)
            .background(Color.theme.backgroundColor)
    }
}


struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin, showHoldingColumn: true)
            CoinRowView(coin: dev.coin, showHoldingColumn: true).preferredColorScheme(.dark)
        }
    }
}


extension CoinRowView {
    private var leftColumn: some View {
        HStack {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
                .frame(minWidth: 40)
            CoinImageView(coin: coin).frame(width: 30,height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading,6)
                .foregroundColor(Color.theme.accentColor)
        }
    }
    
    private var middleColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith6Decimals()).bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }.foregroundColor(Color.theme.accentColor)
    }
    
    private var trailingColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(Color.theme.accentColor)
            Text(coin.priceChangePercentage24H?.asPercentageString() ?? "0.00%")
                .foregroundColor((coin.priceChangePercentage24H  ?? 0) >= 0 ? Color.theme.greenColor : Color.theme.redColor)
        }.frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)
    }
}
