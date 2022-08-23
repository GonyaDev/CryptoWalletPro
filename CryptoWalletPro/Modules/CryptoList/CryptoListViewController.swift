//
//  CryptoListViewController.swift
//  CryptoWalletPro
//
//  Created by Алексей Гончаров on 27.07.2022.
//

import UIKit
import SwiftUI

class CryptoListViewController: UIViewController {

    let presenter: CryptoListPresenter
    
    var coinInfoArray = [CurrencyInfoData]()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()
    
    let loadingIndicator: UIActivityIndicatorView = {
        let progress = UIActivityIndicatorView(style: .large)
        progress.startAnimating()
        return progress
    }()
    
     lazy var logoutButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "arrow.backward.circle.fill"), style: .plain, target: self, action: #selector(didTapLogout))
        button.tintColor = .white
        return button
    }()
    
    lazy var sortButton: UIBarButtonItem = {
       let button = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down.circle.fill"), style: .plain, target: self, action: #selector(didTapSort))
       button.tintColor = .white
       return button
   }()
    
    init() {
        let presenter = CryptoListPresenterImpl()
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        title = "CryptoWalletPro"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItems = [logoutButton, sortButton,]
        setupLayout()
        tableView.delegate = self
        tableView.dataSource = self
        presenter.viewDidLoad()
    }
    
    func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 50),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func didTapLogout() {
        presenter.didTapLogout()
    }
    
    @objc func didTapSort() {
        presenter.didTapSort()
    }
}

extension CryptoListViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = coinInfoArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coinInfo = coinInfoArray[indexPath.row]
        let coinDetailView = CoinDetailViewController(coinInfo: coinInfo)
        //present(hostingController, animated: true)
        navigationController?.pushViewController(coinDetailView, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CryptoListViewController: CryptoListView {
    
    func showLoginScreen() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true)
    }
    
    func loadingIndicator(isHidden: Bool) {
        loadingIndicator.isHidden = isHidden
    }
    
    func show(coinsInfo: [CurrencyInfoData]) {
        coinInfoArray = coinsInfo
        tableView.reloadData()
    }
}
