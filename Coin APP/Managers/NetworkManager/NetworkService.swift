

import Foundation

protocol NetworkService {
    func getData() async throws -> ResponseModel
}
