//
//  NewsViewModel.swift
//  TochkaTask
//
//  Created by Mihail Tumakov on 07.02.2021.
//

import UIKit
import CoreData
import Alamofire

protocol NewsViewModelProtocol {
    var updateViewData: ((ViewData)-> ())? { get set }
    func startFetch()
    func fetchNextPage()
}

final class NewsViewModel: NewsViewModelProtocol {
    var updateViewData: ((ViewData) -> ())?
    private let coreDataManager = CoreDataManager()
    private var articles: [ArticleMO] = []
    private var page: Int = 1
    private let pageSize: Int = 20
    private var totalCount: Int = 0
    
    init() {
        updateViewData?(.initial)
    }
    
    public func fetchNextPage() {
        
        guard page * pageSize < totalCount else {
            return
        }
        page+=1
        print("Page number is \(page)")
        fetchArticles(page: page)
    }
    
    public func startFetch() {
        self.coreDataManager.deleteArticles()
        fetchArticles()
    }
    
    private func fetchArticles(from date: Date) {
        print("Fetch articles from date \(date.dateToString())")
        APIClient.fetch(from: date, to: Date()) { result in
            self.updateData(result: result)
        }
    }
    
    public func fetchArticles(page: Int) {
        print("Fetch articles by page \(page)")
        APIClient.fetch(pageSize: pageSize, page: page) { result in
            self.updateData(result: result)
        }
    }
    
    public func fetchArticles() {
        print("Fetch articles")
        APIClient.fetch(pageSize: pageSize) { result in
            self.updateData(result: result)
        }
    }
    
    private func updateData(result: Result<ViewData.ArticlesResponse, AFError>) {
        switch result {
            case .success(let success):
                print("Total results в ответе на запрос: \(success.totalResults)")
                self.totalCount = success.totalResults
                for el in success.articles {
                    self.coreDataManager.saveArticle(id: el.hashValue, author: el.author, description: el.description, publishedAt: el.publishedAt.toDate(), title: el.title, url: el.url, urlToImage: el.urlToImage)
                }
                self.updateViewData?(.success(self.coreDataManager.fetchArticles()))
            case .failure(let error):
                print(error.localizedDescription)
                self.updateViewData?(.failure)
            }
    }
}
