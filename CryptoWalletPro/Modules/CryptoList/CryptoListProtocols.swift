//
//  CryptoListProtocols.swift
//  CryptoWalletPro
//
//  Created by Алексей Гончаров on 13.08.2022.
//

import Foundation

protocol CryptoListView: AnyObject {
    func showLoginScreen()
    func loadingIndicator(isHidden: Bool)
    func show(coinsInfo: [CurrencyInfoData])
}

protocol CryptoListPresenter {
    func viewDidLoad()
    func didTapLogout()
    func didTapSort()
}
