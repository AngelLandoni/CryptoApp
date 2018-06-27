//
//  PortfolioDB.swift
//  CryptoApp
//
//  Created by Angel Landoni on 26/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import RealmSwift

///
/// This protocol represents all the posible actions over the portfolio db.
/// Class scope abstraction.
///
protocol PortfolioDBActions: class {
    func saveCoin(withModel: PortfolioItemDBModel)
    func loadAllCoins() -> Results<PortfolioItemDBModel>
    
    func deleteAll()
}

///
/// This class Handles the portfolio database.
///
final class PortfolioDB: PortfolioDBActions {
    /// This var contains a reference to the database.
    private var database: Realm
    
    // MARK: - Constructors -
    
    /// This method is the main constructor, allocs all the components neededs.
    init() {
        // Try to get the context.
        database = try! Realm()
    }
    
    // MARK: - Public Methods -
    
    /// This method saves a coin into database.
    ///
    /// - parameter withModel: Coin to save.
    ///
    func saveCoin(withModel coint: PortfolioItemDBModel) {
        try? database.write {
            database.add(coint, update: true)
        }
    }
    
    /// This method loads all the coins.
    ///
    /// - returns: A list of portfolio coins.
    ///
    func loadAllCoins() -> Results<PortfolioItemDBModel> {
        return database.objects(PortfolioItemDBModel.self)
    }
    
    /// This method removes all the items from database.
    func deleteAll() { try? database.write { database.deleteAll() } }
}
