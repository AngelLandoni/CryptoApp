//
//  CryptoListView.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import UIKit

///
/// This class represents a list of crypto currencies.
///
final class CryptoListView: UIViewController, CryptoListViewUnion {
    // MARK: - Vars -
    
    /// This var contains the injector.
    private var injector: CryptoListInjectorBehaviors?
    
    /// This var contains the table handler.
    private var tableHandler: TableHandler?
    
    /// This var contains the presenter.
    private lazy var presenter: CryptoListPresenterUnion? = {
        // Check if the injector is null.
        guard injector != nil else {
            print("[CryptoListView]Error: Error on get presenter. Injector is null")
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
        tableHandler?.setHotLoad(callback: { page in
            self.presenter?.loadAllCryptoInformation(withPage: page)
        })
        tableHandler?.setOnTap(callback: { coin in
            self.presenter?.presentDetailView(withCoin: coin)
        })
        return table
    }()
    
    // MARK: - Constructors -
    
    init(withInjector injector: CryptoListInjectorBehaviors) {
        super.init(nibName: nil, bundle: nil)
        self.injector = injector
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    // MARK: - View Controller Methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadAllCryptoInformation(withPage: 0)        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.checkNetworkState()
    }
    
    // MARK: - Private methods -
    
    /// This method setups the view.
    private func setup() {
        // Submit table view.
        view.addSubview(tableView)
        // Setting up the controller.
        title = NSLocalizedString("list",
                                  tableName: "GeneralStrings", comment: "")
    }
    
    func appendCoins(withEntities coins: [CoinEntity]) {
        tableHandler?.appendCoints(withEntities: coins)
    }
    
    func moveToDetailView(withCoin coin: CoinEntity) {
        let detailController: CryptoDetailView = CryptoDetailModule.generateCryptoDetail()
        detailController.coin = coin
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    func showNoInternetMessage() {
        let title: UILabel = UILabel()
        title.text = NSLocalizedString(
            "noInternetConnection",
            tableName: "GeneralStrings", comment: "")
        tableView.backgroundView = title
    }
    
    func hideNoInternetMessage() { tableView.backgroundView = nil }
    
    func refreshTable() { tableView.reloadData() }
    
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
