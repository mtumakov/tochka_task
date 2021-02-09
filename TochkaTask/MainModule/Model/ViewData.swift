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
    case success(NewsResponse)
    case failure
    
    struct NewsResponse: Codable {
        let status: String
        let totalResults: Int
        let articles: [NewsData]
    }

    struct NewsData: Codable {
        var author: String?
        var title: String?
        var description: String?
        var url: String?
        var urlToImage: String?
        var publishedAt: String?
        var content: String?
    }
}
