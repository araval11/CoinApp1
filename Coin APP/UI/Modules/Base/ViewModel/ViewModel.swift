//
//  ViewModel.swift
//  SwiftBoilerPlate
//
//  Created by AKASH BOGHANI on 10/03/24.
//

import Foundation

@MainActor
class ViewModel {
    // MARK: - Dependencies
    @Injected var router: Router
    @Injected var networkServices: NetworkService
}
