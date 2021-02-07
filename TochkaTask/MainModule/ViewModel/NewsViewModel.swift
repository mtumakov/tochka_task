//
//  NewsViewModel.swift
//  TochkaTask
//
//  Created by Mihail Tumakov on 07.02.2021.
//

import Foundation

protocol NewsViewModelProtocol {
    var updateViewData: ((ViewData)-> ())? { get set }
    func startFetch()
}

final class NewsViewModel: NewsViewModelProtocol {
    var updateViewData: ((ViewData) -> ())?
    
    init() {
        updateViewData?(.initial)
    }
    
    public func startFetch() {
        updateViewData?(.loading(ViewData.NewsData(imageUrl: nil, title: nil, description: nil)))
    }
}
