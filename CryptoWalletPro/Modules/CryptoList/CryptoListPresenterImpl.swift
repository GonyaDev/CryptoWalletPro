//
//  CryptoListPresenter.swift
//  CryptoWalletPro
//
//  Created by Алексей Гончаров on 13.08.2022.
//

import Foundation
import UIKit

final class CryptoListPresenterImpl: CryptoListPresenter {
    
    weak var view: CryptoListView?
    
    let coinsArray = [ "btc", "eth", "tron", "luna", "polkadot", "dogecoin", "tether", "stellar", "cardano", "xrp"]
    var coinInfoArray = [CurrencyInfoData]()
    
    private let networkService = NetworkService()

    func viewDidLoad() {
        if UserDefaults.standard.bool(forKey: "isAlreadyLoggined") != true {
            view?.showLoginScreen()
        }
        
        Task {
            await MainActor.run {
                view?.loadingIndicator(isHidden: false)
            }
            let allResults: [CurrencyInfoData] = await withTaskGroup(of: CurrencyInfoData?.self, body: { taskGroup in
                for coin in coinsArray {
                    taskGroup.addTask {
                        let info = try? await self.networkService.getInfo(for: coin)
                        return info
                    }
                }
                return await taskGroup
                    .compactMap{$0}
                    .reduce([CurrencyInfoData]()) { partialResult, infoData in
                        var partialResult = partialResult
                        partialResult.append(infoData)
                        return partialResult
                    }
            })
            coinInfoArray = allResults
            
            await MainActor.run {
                view?.show(coinsInfo: coinInfoArray)
                view?.loadingIndicator(isHidden: true)
            }
        }
    }
}
