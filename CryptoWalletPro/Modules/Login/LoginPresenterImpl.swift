//
//  LoginPresenterImpl.swift
//  CryptoWalletPro
//
//  Created by Алексей Гончаров on 16.08.2022.
//

import Foundation
import UIKit

let isAlreadyLogginedKey = "isAlreadyLoggined"

final class LoginPresenterImpl: LoginPresenter {
    
    weak var view: LoginView?
    
    //MARK: - Constants
    
    let userEmail = "rambo@yandex.ru"
    let userPassword = "0000"
    
    func didTapLogin(email: String, password: String) {
        if email == userEmail && password == userPassword {
            UserDefaults.standard.set(true, forKey: isAlreadyLogginedKey)
            view?.dismiss()
        } else {
            view?.showAlert()
        }
    }
}
