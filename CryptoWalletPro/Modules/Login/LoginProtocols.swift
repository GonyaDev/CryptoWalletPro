//
//  LoginProtocols.swift
//  CryptoWalletPro
//
//  Created by Алексей Гончаров on 16.08.2022.
//

import Foundation

protocol LoginView: AnyObject {
    func dismiss()
    func showAlert()
}

protocol LoginPresenter {
    func didTapLogin(email: String, password: String) 
}
