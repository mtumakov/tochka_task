//
//  NewsViewModel.swift
//  TochkaTask
//
//  Created by Mihail Tumakov on 07.02.2021.
//

import Foundation
import CoreData

protocol NewsViewModelProtocol {
    var updateViewData: ((ViewData)-> ())? { get set }
    func startFetch()
}

final class NewsViewModel: NewsViewModelProtocol {
    var updateViewData: ((ViewData) -> ())?
    private let coreDataManager = CoreDataManager()
    
    init() {
        updateViewData?(.initial)
    }
    
    public func startFetch() {
        self.updateViewData?(.loading)
        APIClient.fetch() { result in
            switch result {
                case .success(let success):
                    self.updateViewData?(.success(success))
                case .failure(let error):
                    print(error.localizedDescription)
                    self.updateViewData?(.failure)
                }
        }
    }
}
