//
//  ViewData.swift
//  TochkaTask
//
//  Created by Mihail Tumakov on 07.02.2021.
//

import Foundation

enum ViewData {
    case initial
    case success([ArticleMO])
    case failure
    
    struct ArticlesResponse: Codable {
        let status: String
        let totalResults: Int
        let articles: [Article]
    }

    struct Article: Codable, Hashable {
        var author: String?
        var title: String?
        var description: String?
        var url: URL?
        var urlToImage: URL?
        var publishedAt: String
    }
}

extension ArticleMO {
    func convertToArticle() -> ViewData.Article {
        ViewData.Article(author: author, title: title, description: description, url: url, urlToImage: urlToImage, publishedAt: publishedAt?.dateToString() ?? "")
    }
}

extension Date {
    func dateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}

extension String {
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return formatter.date(from: self)!
    }
}
