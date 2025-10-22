//
//  CoinImageService.swift
//  CryptoTracker
//
//  Created by Apple on 22/10/25.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    private let coinData: CoinModel
    private let fileManger = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    init(coin: CoinModel) {
        self.coinData = coin
        self.imageName = coin.id
        getCoinImage()
    }
    private func getCoinImage() {
        if let savedImage = fileManger.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
        } else {
            downloadImage()
        }
    }
    private func downloadImage() {
        guard let url = URL(string: coinData.image) else { return }
        imageSubscription =  NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage in
                guard let image = UIImage(data: data) else {
                    throw URLError(.badServerResponse)
                }
                return image
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: {[weak self] (returedImage) in
                guard let self = self else { return }
                self.image = returedImage
                self.imageSubscription?.cancel()
                self.fileManger.saveImage(image: returedImage, imageName: imageName, folderName: folderName)
            })
    }
}


class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    private let coinData: CoinModel
    private var cancellable = Set<AnyCancellable>()
    private var coinImageDataService: CoinImageService
    init(coin: CoinModel) {
        self.coinData = coin
        self.coinImageDataService = CoinImageService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinImageDataService.$image.sink { [weak self] _ in
            self?.isLoading = false
        } receiveValue: { [weak self] (returnedImage) in
            self?.image = returnedImage
        }.store(in: &cancellable)

    }
}
