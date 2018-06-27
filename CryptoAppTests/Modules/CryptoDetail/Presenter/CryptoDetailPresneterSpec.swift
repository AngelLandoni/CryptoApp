//
//  CryptoAppTests.swift
//  CryptoAppTests
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import Quick
import Nimble

import RealmSwift

@testable import CryptoApp

class CryptoDetailPresenterSpec: QuickSpec {
    override func spec() {
        
        class CryptoDetailViewMock: CryptoDetailViewUnion {
            var updateWasCalled: Bool = false
            var updateChartWasCalled: Bool = false
            var bouthAlertWasCalled: Bool = false
            var lockScreenWasCalled: Bool = false
            var unlockScreenWasCalled: Bool = false
            var showErrorOnLoadingWasCalled: Bool = false
            var showErrorOnByCoinWasCalled: Bool = false
            
            var coinDetailExposer: CoinDetailEntity?
            var coinHistoricalExposer: [CoinHistoricalEntity]?
            
            func update(withCoinDetail coin: CoinDetailEntity) {
                updateWasCalled = true
                coinDetailExposer = coin
            }
            
            func updateChart(withEntities entities: [CoinHistoricalEntity]) {
                updateWasCalled = true
                coinHistoricalExposer = entities
            }
            
            func showBoughtAlert() {
                bouthAlertWasCalled = true
            }
            
            func lockScreen() {
                lockScreenWasCalled = true
            }
            
            func unlockScreen() {
                unlockScreenWasCalled = true
            }
            
            func showErrorOnLoading() {
                showErrorOnLoadingWasCalled = true
            }
            
            func showErrorOnBuyCoin() {
                showErrorOnByCoinWasCalled = true
            }
        }
        
        class CoinNetAdapterMock: CoinNetAdapterActions {
            var requestCoinsWasCalled: Bool = false
            var requestCoinDetailWasCalled: Bool = false
            var requestCoinHistoricalWasCalled: Bool = false
            
            var coinModel: CoinModel?
            var coinHistoricalModel: [CoinHistoricalModel]?
            
            func requestCoins(withPage: Int,
                              successCallback: @escaping ([CoinModel]) -> Void,
                              errorCallback: @escaping (Error) -> Void) {
                requestCoinsWasCalled = true
            }
            
            func requestCoinDetail(withId id: Int,
                                   successCallback: @escaping (CoinModel) -> Void,
                                   errorCallback: @escaping (Error) -> Void) {
                requestCoinDetailWasCalled = true
                successCallback(coinModel!)
                errorCallback(NSError() as Error)
            }
            
            func requestCoinHistorical(withId id: Int,
                                       successCallback: @escaping ([CoinHistoricalModel]) -> Void,
                                       errorCallback: @escaping (Error) -> Void) {
                requestCoinHistoricalWasCalled = true
                successCallback(coinHistoricalModel!)
                errorCallback(NSError() as Error)
            }
        }
        
        class PortfolioNetAdapterMock: PortfolioNetAdapterActions {
            var loadPortfolioWasCalled: Bool = false
            var buyWasCalled: Bool = false
            
            var tradeModel: TradeModel?
            
            func loadPortfolio(successCallback: @escaping ([CoinPortfolioModel]) -> Void,
                               errorCallback: @escaping (Error) -> Void) {
                loadPortfolioWasCalled = true
            }
            
            func buy(withCoin: CoinEntity,
                     andAmount: Float,
                     andDate: Date,
                     successCallback: @escaping (TradeModel) -> Void,
                     errorCallback: @escaping (Error) -> Void) {
                buyWasCalled = true
                successCallback(tradeModel!)
                errorCallback(NSError() as Error)
            }
        }
        
        class PortfolioDBMock: PortfolioDBActions {
            var saveCoinWasCalled: Bool = false
            
            var coinPortfolioItemDBModel: PortfolioItemDBModel?
            
            func saveCoin(withModel model: PortfolioItemDBModel) {
                saveCoinWasCalled = true
                coinPortfolioItemDBModel = model
            }
            
            func loadAllCoins() -> Results<PortfolioItemDBModel> {
                return try! Realm(
                    configuration: Realm.Configuration(inMemoryIdentifier: "test"))
                    .objects(PortfolioItemDBModel.self)
            }
            
            func deleteAll() {
                
            }
        }
        
        class UserInteractionStateMachineMock: UserInteractionStateMachineActions {
            var state: Bool = false
            
            var shouldReloadPortfolio: Bool {
                get { return false }
                set { state = newValue }
            }
        }
        
        var subject: CryptoDetailPresenter?
        var view: CryptoDetailViewMock?
        var coinsNetApi: CoinNetAdapterMock?
        var portfolioNetApi: PortfolioNetAdapterMock?
        var portfolioDBHandler: PortfolioDBMock?
        var userStateMachine: UserInteractionStateMachineMock?
        var coin: CoinEntity?
        
        beforeEach {
            view = CryptoDetailViewMock()
            coinsNetApi = CoinNetAdapterMock()
            portfolioNetApi = PortfolioNetAdapterMock()
            portfolioDBHandler = PortfolioDBMock()
            userStateMachine = UserInteractionStateMachineMock()
            coin = CoinEntity()
            
            subject = CryptoDetailPresenter(
                withView: view!,
                andCoin: coin!,
                andCoinsNetApi: coinsNetApi!,
                andPortfolioNetApi: portfolioNetApi!,
                andPortfolioDBHandler: portfolioDBHandler!,
                andUserInterationStateMachine: userStateMachine!
            )
        }
        
        describe("loadDetails") {
            beforeEach {
                coinsNetApi?.coinModel = CoinModel(withDictionary: [
                    "id": -120,
                    "name": "BatMan",
                    "percent_change_1h": "123",
                    "percent_change_24h": "321",
                    "percent_change_7d": "331",
                    "price_btc": "12222",
                    "price_usd": "333322",
                    "symbol": "BAT",
                    "rank": 154,
                    "total_supply": 1,
                    "updated_at": "2018-06-27T08:29:04+00:00"
                ])
                subject?.loadDetails()
            }
            
            it("should call the net api") {
                expect(coinsNetApi?.requestCoinDetailWasCalled) == true
            }
           
            it("should call the view update method") {
                expect(view?.updateWasCalled) == true
            }
            
            it("should call the view show error on loading") {
                expect(view?.showErrorOnLoadingWasCalled) == true
            }
            
            it("should set the correct coin entity") {
                expect(view?.coinDetailExposer?.name) == "BatMan"
                expect(view?.coinDetailExposer?.percentChange1H) == "123"
                expect(view?.coinDetailExposer?.symbol) == "BAT"
                expect(view?.coinDetailExposer?.priceBTC) == "12222"
                expect(view?.coinDetailExposer?.priceUSD) == "333322"
                expect(view?.coinDetailExposer?.rank) == 154
                expect(view?.coinDetailExposer?.totalSupply) == 1
                expect(view?.coinDetailExposer?.updatedAt) == "2018-06-27T08:29:04+00:00"
            }
        }
        
        describe("loadHistorical") {
            beforeEach {
                coinsNetApi?.coinHistoricalModel = [
                    CoinHistoricalModel(withDictionary: [
                        "price_usd": "1000",
                        "snapshot_at": "2018-06-27T08:29:04+00:00"
                    ])
                ]
                subject?.loadHistorical()
            }
            
            it("should call the net api") {
                expect(coinsNetApi?.requestCoinHistoricalWasCalled) == true
            }
            
            it("should call the view update method") {
                expect(view?.updateWasCalled) == true
            }
            
            it("should call the view show error on loading") {
                expect(view?.showErrorOnLoadingWasCalled) == true
            }
            
            it("should set the correct coin entity") {
                expect(view?.coinHistoricalExposer?.first?.price) == 1000
                expect(view?.coinHistoricalExposer?.first?.date) == DateHandler.fromStringToDate(buffer: "2018-06-27T08:29:04+00:00")
            }
        }
        
        describe("buyCoin") {
            beforeEach {
                portfolioNetApi?.tradeModel = TradeModel(withDictionary: [
                    "id": 2,
                    "coin_id": 3,
                    "user_id": 4,
                    "price_usd": Float(2),
                    "total_usd": 5.5,
                    "amount": Float(3),
                    "updated_at": "2018-06-27T08:29:04+00:00",
                    "traded_at": "2018-06-27T08:29:04+00:00",
                    "created_at": "2018-06-27T08:29:04+00:00",
                ])
                
                subject?.buyCoin(withAmount: 2.3)
            }
            
            // We can not test the nil case because the constructor
            // requires a no option value.
            context("when the coin is NOT nil") {
                it("should call the buy net api method") {
                    expect(portfolioNetApi?.buyWasCalled) == true
                }
                
                it("should lock the screen") {
                    expect(view?.lockScreenWasCalled) == true
                }
                
                it("should unlock the screen") {
                    expect(view?.unlockScreenWasCalled) == true
                }
                
                it("should call show bought alert") {
                    expect(view?.bouthAlertWasCalled) == true
                }
                
                it("should call show error on buy coin") {
                    expect(view?.showErrorOnByCoinWasCalled) == true
                }
                
                it("should call save coin") {
                    expect(portfolioDBHandler?.saveCoinWasCalled) == true
                }
                
                it("should has the correct trade") {
                    expect(portfolioDBHandler?.coinPortfolioItemDBModel?.coinId) == 3
                    expect(portfolioDBHandler?.coinPortfolioItemDBModel?.amount) == 3
                    expect(portfolioDBHandler?.coinPortfolioItemDBModel?.date) == DateHandler.fromStringToDate(buffer: "2018-06-27T08:29:04+00:00")
                    expect(portfolioDBHandler?.coinPortfolioItemDBModel?.priceUSD) == 2
                }
            }
        }
        
    }
}
