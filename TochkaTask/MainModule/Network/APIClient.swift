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
    
    static func fetch(completion: @escaping (Result<ViewData.NewsResponse, AFError>) -> Void) {
        let headers = HTTPHeaders(arrayLiteral: HTTPHeader(name: NetworkHeader.apiKey.rawValue, value: apiKey))
        let params: Parameters = [NetworkParams.country.rawValue: Country.ru.rawValue]
        AF.request(uri + NetworkUrl.topHeadlines.rawValue, parameters: params, encoding: URLEncoding(destination: .queryString), headers: headers).responseDecodable { (response: DataResponse<ViewData.NewsResponse, AFError>) in
            completion(response.result)
        }
    }
}

enum NetworkUrl: String {
    case topHeadlines = "top-headlines"
    case everything = "everything"
}

enum Country: String {
    case us = "us"
    case ru = "ru"
}

enum NetworkParams: String {
    case country = "country"
    case sources = "sources"
    case text  = "q"
    case title = "qInTitle"
    case domains = "domains"
}

enum NetworkHeader: String {
    case apiKey = "x-api-key"
}


