//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Apple on 25/10/25.
//

import SwiftUI

struct DetailView: View {
    @StateObject var vm: DetailViewModel
    @State private var showFullText: Bool = false
    private let column:[GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    let coin: CoinModel
    init(coin: CoinModel) {
        self.coin = coin
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: coin).frame(height: 150).padding(.vertical)
                VStack(spacing: 20) {
                    Text("OverView").font(.title).bold()
                        .foregroundColor(Color.theme.accentColor)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    Divider()
                    ZStack {
                        if let description = vm.description,!description.isEmpty {
                            VStack(alignment: .leading) {
                                Text(description)
                                    .lineLimit(showFullText ? nil : 3)
                                    .font(.callout)
                                    .foregroundColor(Color.theme.secondaryTextColor)
                                Button {
                                    withAnimation(.easeInOut) {
                                        showFullText.toggle()
                                    }
                                    
                                } label: {
                                    Text(showFullText ? "Less..." : "Read More...").font(.caption)
                                        .fontWeight(.bold)
                                        .padding(.vertical,4)
                                }.accentColor(Color.blue)

                            }.frame(maxWidth: .infinity,alignment: .leading)
                        }
                    }
                    LazyVGrid(columns: column,alignment:.leading, spacing: 30) {
                        ForEach(vm.overViewStaticstics) { overviewStatic in
                            StaticsticsView(stat: overviewStatic)
                        }
                    }
                    Text("Additional Details").font(.title).bold()
                        .foregroundColor(Color.theme.accentColor)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    Divider()
                    LazyVGrid(columns: column,alignment:.leading, spacing: 30) {
                        ForEach(vm.additionlaStaticstics) { additionalStatic in
                            StaticsticsView(stat: additionalStatic)
                        }
                    }
                    VStack(alignment: .leading,spacing: 20) {
                        if let websiteUrl = vm.websiteUrl, let url = URL(string: websiteUrl) {
                            Link("Website", destination: url)
                        }
                        if let redditUrl = vm.websiteUrl, let url = URL(string: redditUrl) {
                            Link("Reddit", destination: url)
                        }
                    }.accentColor(.blue)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .font(.headline)
                }.padding()
            }
        }.navigationTitle(coin.name)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Text(vm.coin.symbol.uppercased())
                            .font(.headline)
                            .foregroundColor(Color.theme.accentColor)
                        CoinImageView(coin: vm.coin).frame(width: 25, height: 25)
                    }
                }
            }
    }
}


struct DetailLoadingView: View {
    @Binding var coin: CoinModel?
    init(coin: Binding<CoinModel?>) {
        self._coin = coin
    }
    var body: some View {
        if coin != nil {
            DetailView(coin: coin!)
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}
