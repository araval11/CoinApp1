//
//  NewsReponseModel.swift
//  BoilerPlate
//
//  Created by AKASH on 21/11/23.
//

import Foundation

// MARK: - ResponseModel
struct ResponseModel: Codable {
    let data: [DataModel]?
}

// MARK: - Datum
struct DataModel: Codable {
    let id, rank, symbol, name: String?
    let supply, maxSupply, marketCapUsd, volumeUsd24Hr: String?
    let priceUsd, changePercent24Hr, vwap24Hr: String?
    let explorer: String?
}
