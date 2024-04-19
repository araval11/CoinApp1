

import Foundation

// MARK: - API
enum API {
    case assets
}

// MARK: - APIProtocol
extension API: APIProtocol {
    var baseURL: String {
        "https://api.coincap.io/v2/"
    }
    
    var path: String {
        switch self {
        case .assets:
            return "assets"
        }
    }
    
    var method: APIMethod {
        switch self {
        case .assets:
            return .get
        }
    }
    
    var task: Request {
        switch self {
        case .assets:
            return .requestPlain
        }
    }
    
    var header: [String: String] {
        switch self {
        case .assets:
            return ["Content-Type" : "application/json"]
        }
    }
}
