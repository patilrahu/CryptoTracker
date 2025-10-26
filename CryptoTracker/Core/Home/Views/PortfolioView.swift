//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by Apple on 23/10/25.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: HomeViewModel
    @State var selectedCoin: CoinModel? = nil
    @State var quantityText: String = ""
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    ScrollView(.horizontal,showsIndicators: false) {
                        LazyHStack {
                            ForEach(vm.allCoins) { coin in
                                coinItemView(for: coin)
                            }
                        }.padding(.vertical,4).padding(.leading)
                    }
                    if (selectedCoin != nil) {
                        VStack(spacing:20) {
                            HStack {
                                Text("Current Price Of \(selectedCoin?.symbol.uppercased() ?? ""):")
                                Spacer()
                                Text("\(selectedCoin?.currentPrice.formatNumber() ?? "0.00")")
                            }
                            Divider()
                            HStack {
                                Text("Amount in your portfolio:")
                                Spacer()
                                TextField("Ex: 1.4", text: $quantityText).multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                            }
                            Divider()
                            HStack {
                                Text("Current Value:")
                                Spacer()
                                Text(getDoubleValue().formatNumber())
                            }
                        }
                        .font(.headline)
                        .padding()
                    }
                }.navigationTitle("Edit Portfolio")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            XMarkButton(dismiss: _dismiss)
                                
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                guard let coin = selectedCoin else {return}
                                vm.updateportfoli(coin: coin, amount: Double(quantityText) ?? 0)
                            }) {
                                Text("Save")
                            }.font(.headline)
                                
                        }
                    }
            }.onChange(of: vm.searchText) { value in
                if (value == "") {
                    selectedCoin = nil
                }
            }
        }
    }
    
    private func getDoubleValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func coinItemView(for coin: CoinModel) -> some View {
            CoinLogoView(coin: coin)
                .frame(width: 75)
                .padding(4)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(selectedCoin?.id == coin.id ? Color.theme.greenColor : Color.clear, lineWidth: 2)
                )
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        selectedCoin = coin
                        if let portfolio = vm.portFolioCoins.first(where: {$0.id == coin.id}) {
                            quantityText = "\(portfolio.currentHoldings ?? 0)"
                        } else {
                            quantityText = ""
                        }
                    }
                }
        }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView().environmentObject(dev.homeVM)
    }
}


