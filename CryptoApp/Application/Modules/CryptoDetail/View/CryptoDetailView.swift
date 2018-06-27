//
//  CryptoDetailView.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import UIKit
import SwiftChart

///
/// This class represents the detail view.
///
class CryptoDetailView: UIViewController, CryptoDetailViewUnion {
    // MARK: - Vars -
    
    /// This var contains the injector.
    private var injector: CryptoDetailInjectorBehaviors?
    
    // MARK: - Components -
    
    @IBOutlet weak var symbolValueLabel: UILabel!
    @IBOutlet weak var priceBTCValueLabel: UILabel!
    @IBOutlet weak var priceUSDValueLabel: UILabel!
    @IBOutlet weak var rankValueLabel: UILabel!
    @IBOutlet weak var totalSupplyValueLabel: UILabel!
    @IBOutlet weak var lastUpdateValueLabel: UILabel!
    @IBOutlet weak var progressChart: Chart!
    
    let loadingScreen: LoadingScreen = LoadingScreen(frame: UIScreen.main.bounds)
    
    // MARK: - Public Vars -
    
    var coin: CoinEntity?
    
    /// This var contains the presenter.
    private lazy var presenter: CryptoDetailPresenterUnion? = {
        // Check if the injector is null.
        guard injector != nil else {
            print("[CryptoListView]Error: Error on get presenter. Injector is null.")
            return nil
        }
        // Check if the coin is not null.
        guard coin != nil else {
            print("[CryptoListView]Error: Error the coin is null.")
            return nil
        }
        // Generate the presenter.
        return injector?.getPresenter(
            withView: self,
            andCoin: coin!
        )
    }()
    
    // MARK: - Constructors -
    
    init(nibName nibNameOrNil: String?,
         andInjector injector: CryptoDetailInjectorBehaviors) {
        super.init(nibName: nibNameOrNil, bundle: nil)
        self.injector = injector
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    
    // MARK: - View Controller Methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting up the controller.
        title = coin?.name
        // Load the data needed.
        presenter?.loadDetails()
        presenter?.loadHistorical()
    }
    
    // MARK: - Xib Events -
    
    @IBAction func onTapBuy(_ sender: UIButton) {
        // Create the alert.
        let alert: UIAlertController = UIAlertController(
            title: NSLocalizedString("amount",
                                     tableName: "AlertStrings", comment: ""),
            message: nil,
            preferredStyle: .alert)
        // Add the text field.
        alert.addTextField { textField in
            textField.text = "1.0"
        }
        // Add the buy button.
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("buy",tableName: "AlertStrings", comment: ""),
            style: .default, handler: { action in
                self.presenter?.buyCoin(
                withAmount: ((alert.textFields![0].text ?? "0.0") as NSString).floatValue)
            }))
        // Add the cancel button.
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("cancel",tableName: "AlertStrings", comment: ""),
            style: .destructive, handler: nil))
        // Finally show the alert.
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Private Methods -
    
    /// This method setups the controller
    private func setup() {

    }
    
    // MARK: - Actions -
    
    /// This method updates the information in the view.
    func update(withCoinDetail coinDetail: CoinDetailEntity) {
        symbolValueLabel.text = coinDetail.symbol
        priceBTCValueLabel.text = coinDetail.priceBTC
        priceUSDValueLabel.text = coinDetail.priceUSD
        rankValueLabel.text = "\(coinDetail.rank ?? 0)"
        totalSupplyValueLabel.text = "\(coinDetail.totalSupply ?? 0)"
        lastUpdateValueLabel.text = coinDetail.updatedAt
    }
    
    /// This method rendes the chart with a speccific information.
    func updateChart(withEntities histories: [CoinHistoricalEntity]) {
        let data: [Double] = histories.map { point -> Double in
            return point.price ?? 0.0
        }
        let series = ChartSeries(data)
        series.area = true
        progressChart.xLabelsFormatter = { (x,y) -> String in
            return ""
        }
        progressChart.add(series)
    }
    
    /// THis method shows an alert with a good boy.
    func showBoughtAlert() {
        // Create the alert.
        let alert: UIAlertController = UIAlertController(
            title: NSLocalizedString("operationFinishedTitle",
                                     tableName: "AlertStrings", comment: ""),
            message: NSLocalizedString("operationFinishedMessage",
                                       tableName: "AlertStrings", comment: ""),
            preferredStyle: .alert)
        // Add the buy button.
        alert.addAction(UIAlertAction(
            title: NSLocalizedString(
                "okButton",
                tableName: "AlertStrings",
                comment: ""),
            style: .default,
            handler: nil))
        // Finally show the alert.
        present(alert, animated: true, completion: nil)
    }
    
    /// This method locks the screen and shows the loading screen.
    func lockScreen() {
        // Disable entire user interaction over the screen.
        (UIApplication.shared.delegate as! AppDelegate)
            .window?.rootViewController?.view.addSubview(loadingScreen)
    }
    
    /// This method unlocks the screen and hides the loading screen.
    func unlockScreen() {
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
    
    //// This method shows a error buying alert.
    func showErrorOnBuyCoin() {
        // Create the alert.
        let alert: UIAlertController = UIAlertController(
            title: NSLocalizedString("errorOnBuyCoin",
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
