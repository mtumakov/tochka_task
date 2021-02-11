//
//  ViewData.swift
//  TochkaTask
//
//  Created by Mihail Tumakov on 07.02.2021.
//

import Foundation
import Alamofire

enum ViewData {
    case initial
    case loading
    case success(ArticlesResponse)
    case failure
    
    struct ArticlesResponse: Codable {
        let status: String
        let totalResults: Int
        let articles: [Article]
    }

    struct Article: Codable {
        var author: String?
        var title: String?
        var description: String?
        var url: URL?
        var urlToImage: URL?
        var publishedAt: String?
    }
}
