//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Apple on 21/10/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var statistics: [StaticsticsModel] = [
        
    ]
    @Published var allCoins:[CoinModel] = []
    @Published var portFolioCoins:[CoinModel] = []
    @Published var searchText: String = ""
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
//        dataService.$allCoins.sink { [weak self] (coins) in
//            self?.allCoins = coins
//        }.store(in: &cancellable)
        $searchText.combineLatest(dataService.$allCoins)
            .map { (text,startingCoins) -> [CoinModel] in
                guard !text.isEmpty else {
                    return startingCoins
                }
                
                let lowerCaseText = text.lowercased()
                return startingCoins.filter {
                    $0.name.lowercased().contains(lowerCaseText) || $0.symbol.lowercased().contains(lowerCaseText) || $0.id.lowercased().contains(lowerCaseText)
                }
                
            }.debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }.store(in: &cancellable)
    }
    
    
    
}
