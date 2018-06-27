//
//  CryptoListViewTableHandler.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import UIKit

typealias TableHandler =
    UITableViewDelegate &
    UITableViewDataSource &
    CryptoListViewTableHandlerActions

///
/// This class handles the portfolio table.
///
final class CryptoListViewTableHandler: NSObject, TableHandler {
    // MARK: - Vars

    /// This var contains the current loaded pages.
    private var pageCounter: Int = 0
    
    /// This var contains the drawer.
    private var drawer: CryptoCurrencyCellDrawer?
    
    /// This var contains the list of coints.
    private var listOfCoins: [CoinEntity] = []
    
    /// This var conatins the callback executed when the table arrives the bottom.
    private var hotLoadCallback: ((Int) -> Void)?
    /// This var contains the callbakc executed when the user taps over a cell.
    private var onTapCell: ((CoinEntity) -> Void)?

    // MARK: - Constructors
    
    init(withDrawer drawer: CryptoCurrencyCellDrawer) {
        self.drawer = drawer
    }
    
    // MARK: - Methods
    
    func registreCells(inTableView tableView: UITableView) {
        tableView.register(UINib(nibName: "CryptoCurrencyCell", bundle: nil),
                           forCellReuseIdentifier: "CryptoCurrencyCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CryptoCurrencyCell = tableView.dequeueReusableCell(
            withIdentifier: "CryptoCurrencyCell") as! CryptoCurrencyCell
        drawer?.draw(inCell: cell, withData: listOfCoins[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // If the table shows the last cell it must call the delegate.
        if indexPath.row == listOfCoins.count - 1 {
            pageCounter += 1
            hotLoadCallback?(pageCounter)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onTapCell?(listOfCoins[indexPath.row])
    }
    
    /// This method sets new coints (replace).
    ///
    /// - parameter withEntities: New coins to set.
    ///
    func setNewCoins(withEntities entities: [CoinEntity]) { listOfCoins = entities }
    
    /// This method adds new coins to the list.
    ///
    /// - paramter withEntities: List of entities to add.
    ///
    func appendCoints(withEntities entities: [CoinEntity]) {
        listOfCoins.append(contentsOf: entities)
    }
    
    /// This method sets the hot reload callback.
    ///
    /// - paramter callback: Callback that will be executed when the user arrives the bottom.
    ///
    func setHotLoad(callback: @escaping (Int) -> Void) { hotLoadCallback = callback }
    
    /// This method sets the on tap callback.
    ///
    /// - paramter callback: Callback that will be executed when the user taps over a cell.
    ///
    func setOnTap(callback: @escaping (CoinEntity) -> Void) { onTapCell = callback }
}
