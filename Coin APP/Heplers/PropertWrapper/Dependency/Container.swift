

import Foundation

// MARK: - Storable
protocol Storable {
    var identifire: UUID { get }
}

// MARK: - Container
class Container<T>: Storable {
    var identifire: UUID = .init()
    var factory: () -> T

    init(factory: @escaping () -> T) {
        self.factory = factory
    }
}
