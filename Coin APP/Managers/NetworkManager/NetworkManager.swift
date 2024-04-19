

import Foundation

final class NetworkManager: NetworkService {
    func getData() async throws -> ResponseModel {
        try await APIService.request(API.assets)
    }
}
