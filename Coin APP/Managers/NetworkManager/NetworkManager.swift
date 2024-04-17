//
//  NetworkManager.swift
//  Squeezee
//
//  Created by AKASH on 04/08/23.
//

import Foundation

final class NetworkManager: NetworkService {
    func getData() async throws -> ResponseModel {
        try await APIService.request(API.assets)
    }
}
