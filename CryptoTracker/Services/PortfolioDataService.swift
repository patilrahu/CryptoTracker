//
//  PortfolioDataService.swift
//  CryptoTracker
//
//  Created by Apple on 25/10/25.
//

import Foundation
import CoreData

class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioModel"
    private let entityName: String = "PortfolioEntity"
    @Published var savedEntities: [PortfolioEntity] = []
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading core data: \(error)")
            }
            self.getPortfolio()
        }
    }
    
    
    func updatePortfolio(coin: CoinModel,amount: Double) {
        print(amount)
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                removeEntity(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
        getPortfolio()
    }
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("ERROR: \(error)")
        }
    }
    
    private func add(coin:CoinModel,amount:Double) {
        let entity =  PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
        
    }
    
    private func update(entity: PortfolioEntity,amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func removeEntity(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("ERROR Saving CoreData: \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
