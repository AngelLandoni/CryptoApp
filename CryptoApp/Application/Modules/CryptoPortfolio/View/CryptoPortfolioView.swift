//
//  CryptoPortfolioView.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import UIKit

///
/// This class represents a list of crypto currencies.
///
final class CryptoPortfolioView: UIViewController, CryptoPortfolioViewUnion {
    // MARK: - Vars -
    
    /// This var contains the injector.
    private var injector: CryptoPortfolioInjectorBehaviors?
    
    /// This var contains the table handler.
    private var tableHandler: PortfolioTableHandler?
    
    /// This var contains the presenter.
    private lazy var presenter: CryptoPortfolioPresenterUnion? = {
        // Check if the injector is null.
        guard injector != nil else {
            print("[CryptoPortfolioView]Error: Error on get presenter. Injector is null")
            return nil
        }
        // Generate the presenter.
        return injector?.getPresenter(withView: self)
    }()
    
    // MARK: - Components -
    
    /// This var contains the main table view.
    private lazy var tableView: UITableView = {
        let table: UITableView = UITableView(frame: UIScreen.main.bounds)
        tableHandler = injector?.getTableHander()
        table.delegate = tableHandler
        table.dataSource = tableHandler
        table.tableFooterView = UIView()
        tableHandler?.registreCells(inTableView: table)
        return table
    }()
    
    /// This var contains the loading screen.
    let loadingScreen: LoadingScreen = LoadingScreen(frame: UIScreen.main.bounds)
    
    // MARK: - Constructors -
    
    init(withInjector injector: CryptoPortfolioInjectorBehaviors) {
        super.init(nibName: nil, bundle: nil)
        self.injector = injector
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    // MARK: - View Controller Methods -
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.loadPortfolio()
    }
  
    // MARK: - Private methods -
    
    /// This method setups the view.
    private func setup() {
        // Submit table view.
        view.addSubview(tableView)
        // Setting up the controller.
        title = NSLocalizedString("portfolio",
                                  tableName: "GeneralStrings", comment: "")
    }
    
    /// This method renders all the portfolio items into the table.
    ///
    /// - parameter withItems: List of items to render.
    ///
    func showPortfolioItems(withItems items: [CoinPortfolioEntity]) {
        tableHandler?.setNewPortfolioItems(withItems: items)
        tableView.reloadData()
    }
    
    /// This method reloads the table.
    func refreshTable() { tableView.reloadData() }
    
    /// This method locks the screen and shows the loading screen.
    func lockScreen() {
        // Disable entire user interaction over the screen.
        view.addSubview(loadingScreen)
    }
    
    /// This method unlocks the screen and hides the loading screen.
    func unlockScreen() {
        // Remove the loading screen.
        loadingScreen.removeFromSuperview()
    }
    
    //// This method shows a error loading alert.
    func showErrorOnLoading() {
        // Create the alert.
        let alert: UIAlertController = UIAlertController(
            title: NSLocalizedString("errorOnLoading",
                                     tableName: "AlertStrings", comment: ""),
            message: nil,
            preferredStyle: .alert)
        // Add the cancel button.
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("okButton",tableName: "AlertStrings", comment: ""),
            style: .destructive, handler: nil))
        // Finally show the alert.
        present(alert, animated: true, completion: nil)
    }
}
