//
//  ProfileVm.swift
//  NewsApp
//
//  Created by AKASH BOGHANI on 10/04/24.
//

import Foundation

final class ProfileVm: ViewModel {
    //MARK: - Properties
    private var disposeBag = Bag()
    private var taskBag = TaskBag()
    private var output = AppSubject<Output>()
    var arrModel: [DataModel] = []
    
    //MARK: - Enums
    enum Input {
        case makeCall
    }
    
    enum Output {
        case loader(isLoading: Bool)
        case showError(msg: String)
        case getData
    }
    
    //MARK: - Functions
    func transform(input: AppAnyPublisher<Input>) -> AppAnyPublisher<Output> {
        input.weekSink(self) { strongSelf, event in
            switch event {
            case .makeCall:
                strongSelf.getData()
            }
        }.store(in: &disposeBag)
        return output.eraseToAnyPublisher()
    }
    
    private func getData() {
        output.send(.loader(isLoading: true))
        Task {
            do {
                let model = try await networkServices.getData()
                arrModel = model.data ?? []
                output.send(.loader(isLoading: false))
                output.send(.getData)
            } catch let error as APIError {
                output.send(.loader(isLoading: false))
                output.send(.showError(msg: error.description))
            } catch {
                output.send(.loader(isLoading: false))
                output.send(.showError(msg: error.localizedDescription))
            }
        }.store(in: &taskBag)
    }
}

