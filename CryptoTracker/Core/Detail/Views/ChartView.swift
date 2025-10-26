//
//  ChartView.swift
//  CryptoTracker
//
//  Created by Apple on 26/10/25.
//

import SwiftUI
import Charts

struct ChartView: View {
    private let price: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor:Color
    private let startingDate: Date
    private let endingDate: Date
    @State private var percentage: CGFloat = 0
    init(coin: CoinModel) {
        self.price = coin.sparkline_in_7d?.price ?? []
        maxY = price.max() ?? 0
        minY = price.min() ?? 0
        let priceChange = (price.last ?? 0) - (price.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.greenColor : Color.theme.redColor
        endingDate = Date(coinGekoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7 * 24 * 60 * 60 )
    }
    var body: some View {
        VStack {
            chartView.frame(height: 200)
                .background(
                    chartBackground
                ).overlay (
                    chartYAxis.padding(.horizontal,4)
                    ,alignment: .leading
                )
            chartDate.padding(.horizontal,4)
        }.font(.caption)
            .foregroundColor(Color.theme.secondaryTextColor)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    withAnimation(.linear(duration: 3)) {
                        percentage = 1.0
                    }
                })
            }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
            
    }
}


extension ChartView {
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in price.indices {
                    let xPosition = geometry.size.width / CGFloat(price.count) * CGFloat(index + 1)
                    let yAxis = maxY - minY
                    let yPosition = (1 - CGFloat((price[index] - minY)) / yAxis) * geometry.size.height
                    if (index == 0) {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2,lineCap: .round,lineJoin: .round))
            .shadow(color: lineColor,radius: 10,x: 0,y: 10)
            .shadow(color: lineColor.opacity(0.5),radius: 10,x: 0,y: 20)
            .shadow(color: lineColor.opacity(0.2),radius: 10,x: 0,y: 30)
            .shadow(color: lineColor.opacity(0.1),radius: 10,x: 0,y: 40)
        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
           
        }
    }
    
    private var chartYAxis: some View {
        VStack {
            Text(maxY.formatNumber())
            Spacer()
            Text(((maxY + minY) / 2).formatNumber())
            Spacer()
            Text(minY.formatNumber())
        }
    }
    
    private var chartDate: some View {
        HStack {
            Text(startingDate.asShortString())
            Spacer()
            Text(endingDate.asShortString())
        }
    }
}
