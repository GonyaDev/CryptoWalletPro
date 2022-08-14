//
//  CoinDetailViewController.swift
//  CryptoWalletPro
//
//  Created by Алексей Гончаров on 04.08.2022.
//

import UIKit
import SwiftUI

struct CoinDetailView: View {
    
    let coinInfo: CurrencyInfoData
    
    var body: some View {
        VStack {
            Image("market")
                .resizable()
                .frame(width: 200, height: 200)
                .tint(Color.yellow)
                .scaleEffect()
            Spacer()
                .frame(height: 50)
            Text("Name: \(coinInfo.name)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .kerning(1.9)
                .frame(maxWidth:.infinity, alignment: .leading)
            Text("Price USD: \(coinInfo.marketData.priceUSD)")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .kerning(1.9)
                .frame(maxWidth:.infinity, alignment: .leading)
            if let dayPercantage = coinInfo.marketData.dayPercentageChange {
                Text("Day Percentage: \(dayPercantage)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .kerning(1.9)
                    .frame(maxWidth:.infinity, alignment: .leading)
            }
            Text("Bitcoin (₿) is a decentralized digital currency that can be transferred on the peer-to-peer bitcoin network.[7] Bitcoin transactions are verified by network nodes through cryptography and recorded in a public distributed ledger called a blockchain. The cryptocurrency was invented in 2008 by an unknown person or group of people using the name Satoshi Nakamoto.[10] The currency began use in 2009,[11] when its implementation was released as open-source software.[6]: ch. 1 ")
            if let hourPercantage = coinInfo.marketData.hourPercentageChange {
                Text("Hour Percentage: \(hourPercantage)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .kerning(1.9)
                    .frame(maxWidth:.infinity, alignment: .leading)
                Spacer()
            }
        }
    }
}
