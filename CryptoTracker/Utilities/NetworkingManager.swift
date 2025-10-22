//
//  NetworkingManager.swift
//  CryptoTracker
//
//  Created by Apple on 21/10/25.
//

import Foundation
import Combine
class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case invalidURL
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "Invalid URL"
            case .unknown:
                return "Unknown error"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data,Error>  {
      return  URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
//            .tryMap { (output) -> Data in
//                guard let response = output.response as? HTTPURLResponse , response.statusCode >= 200 && response.statusCode < 300 else {
//                    throw URLError(.badServerResponse)
//                }
//                return output.data
//            }
            .tryMap({ try handleURLResponse(output: $0)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse , response.statusCode >= 200 && response.statusCode < 300 else {
//            throw URLError(.badServerResponse)
            throw NetworkingError.invalidURL
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
