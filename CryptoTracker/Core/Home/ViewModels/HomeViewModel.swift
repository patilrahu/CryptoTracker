//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Apple on 21/10/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allCoins:[CoinModel] = []
    @Published var portFolioCoins:[CoinModel] = []
    private let dataService = CoinDataService()
    private var cancellable = Set<AnyCancellable>()
    init() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.allCoins.append(DeveloperPreview.instance.coin)
//            self.portFolioCoins.append(DeveloperPreview.instance.coin)
//        }
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$allCoins.sink { [weak self] (coins) in
            self?.allCoins = coins
        }.store(in: &cancellable)
    }
    
}
