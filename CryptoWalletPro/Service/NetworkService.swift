//
//  NetworkService.swift
//  CryptoWalletPro
//
//  Created by Алексей Гончаров on 28.07.2022.
//

import Foundation
import UIKit

struct CurrencyInfo: Decodable {
    let data: CurrencyInfoData
}

struct CurrencyInfoData: Decodable {
    let name: String
    let marketData: CurrencyInfoMarketData
    
    enum CodingKeys: String, CodingKey {
        case name
        case marketData = "market_data"
    }
}

struct CurrencyInfoMarketData: Decodable {
    let priceUSD: Double
    let hourPercentageChange: Double?
    let dayPercentageChange: Double?
    
    enum CodingKeys: String, CodingKey {
        case priceUSD = "price_usd"
        case hourPercentageChange = "percent_change_usd_last_1_hour"
        case dayPercentageChange = "percent_change_usd_last_24_hours"
    }
}

class NetworkService {
    
    func getInfo(for currency: String) async throws -> CurrencyInfoData {
        guard let url = URL(string: "https://data.messari.io/api/v1/assets/\(currency)/metrics") else {
            throw NSError(domain: "URL is incorrect", code: 1, userInfo: nil)
        }
        let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
        print(data)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "Bad Response", code: 1, userInfo: nil)
        }
        
        let info = try JSONDecoder().decode(CurrencyInfo.self, from: data)
        return info.data
    }
}


