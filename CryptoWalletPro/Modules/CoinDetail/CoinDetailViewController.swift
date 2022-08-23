//
//  CryptoListDetailViewController.swift
//  CryptoWalletPro
//
//  Created by Алексей Гончаров on 23.08.2022.
//

import Foundation
import UIKit

class CoinDetailViewController: UIViewController {
    
    let coinInfo: CurrencyInfoData
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    init(coinInfo: CurrencyInfoData) {
        self.coinInfo = coinInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(stackView)
        setupLayout()
        
        let imageContainer = UIView()
        let image = UIImageView(image: UIImage(named: "market"))
        imageContainer.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 200).isActive = true
        image.heightAnchor.constraint(equalToConstant: 200).isActive = true
        image.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor).isActive = true
        image.topAnchor.constraint(equalTo: imageContainer.topAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor).isActive = true
        
        stackView.addArrangedSubview(imageContainer)
        stackView.addArrangedSubview(createLabel(text: "Name: \(coinInfo.name)", font: .systemFont(ofSize: 30)))
        stackView.addArrangedSubview(createLabel(text: "Price USD: \(coinInfo.marketData.priceUSD)", font: .systemFont(ofSize: 30)))
        if let dayPercantage = coinInfo.marketData.dayPercentageChange {
            stackView.addArrangedSubview(createLabel(text:"Day Percentage: \(dayPercantage)", font: .systemFont(ofSize: 30)))
        }
        if let hourPercantage = coinInfo.marketData.hourPercentageChange {
            stackView.addArrangedSubview(createLabel(text: "Hour Percentage: \(hourPercantage)", font: .systemFont(ofSize: 30)))
        }
    }
    
    func setupLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
    
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    func createLabel(text: String, font: UIFont = .systemFont(ofSize: 14)) -> UILabel {
        let label = UILabel()
        label.font = font
        label.text = text
        label.numberOfLines = 0
        return label
    }
}
