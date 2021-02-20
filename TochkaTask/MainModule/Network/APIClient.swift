//
//  APIClient.swift
//  TochkaTask
//
//  Created by Mihail Tumakov on 08.02.2021.
//

import Alamofire

class APIClient {
    static let apiKey = "cb07720519cc40d5bc51d2c8135d825e"
    static let uri = "https://newsapi.org/v2/"
    
    static func fetch(pageSize: Int, page: Int = 1, completion: @escaping (Result<ViewData.ArticlesResponse, AFError>) -> Void) {
        let headers = HTTPHeaders(arrayLiteral: HTTPHeader(name: NetworkHeader.apiKey.rawValue, value: apiKey))
        let params: Parameters = [
            NetworkParams.language.rawValue: Country.ru.rawValue,
            NetworkParams.pageSize.rawValue: pageSize,
            NetworkParams.sortBy.rawValue: ResponseSort.publishedAt.rawValue,
            NetworkParams.page.rawValue: page
        ]
        request(url: uri + NetworkUrl.topHeadlines.rawValue, headers: headers, params: params, completion: completion)
    }
    
    static func fetch(from: Date, to: Date, page: Int = 0, completion: @escaping (Result<ViewData.ArticlesResponse, AFError>) -> Void) {
        let headers = HTTPHeaders(arrayLiteral: HTTPHeader(name: NetworkHeader.apiKey.rawValue, value: apiKey))
        let params: Parameters = [
            NetworkParams.language.rawValue: Country.ru.rawValue,
            NetworkParams.from.rawValue: from.dateToString(),
            NetworkParams.to.rawValue: to.dateToString(),
            NetworkParams.pageSize.rawValue: 15,
            NetworkParams.sortBy.rawValue: ResponseSort.publishedAt.rawValue,
            NetworkParams.page.rawValue: page
        ]
        request(url: uri + NetworkUrl.topHeadlines.rawValue, headers: headers, params: params, completion: completion)
    }
    
    private static func request(url: String, headers: HTTPHeaders, params: Parameters, completion: @escaping (Result<ViewData.ArticlesResponse, AFError>) -> Void) {
        
        AF.request(url, parameters: params, encoding: URLEncoding(destination: .queryString), headers: headers).responseDecodable { (response: DataResponse<ViewData.ArticlesResponse, AFError>) in
            completion(response.result)
        }
    }
}

enum NetworkUrl: String {
    case topHeadlines = "top-headlines"
    case everything = "everything"
}

enum Country: String {
    case ru = "ru"
    case ar = "ar"
    case de = "de"
    case en = "en"
    case es = "es"
    case fr = "fr"
    case he = "he"
    case it = "it"
    case nl = "nl"
    case no = "no"
    case pt = "pt"
    case se = "se"
    case ud = "ud"
    case zh = "zh"
}

enum NetworkParams: String {
    case pageSize = "pageSize"
    case page = "page"
    case sortBy = "sortBy"
    case country = "country"
    case sources = "sources"
    case language = "language"
    case text  = "q"
    case title = "qInTitle"
    case domains = "domains"
    case from = "from"
    case to = "to"
}

enum ResponseSort: String {
    case relevancy = "relevancy"
    case popularity = "popularity"
    case publishedAt = "publishedAt"
}

enum NetworkHeader: String {
    case apiKey = "x-api-key"
}


