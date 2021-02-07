//
//  ViewData.swift
//  TochkaTask
//
//  Created by Mihail Tumakov on 07.02.2021.
//

import Foundation


// прочитать про ассоциативные данные в енаме
enum ViewData {
    case initial
    case loading(NewsData)
    case success(NewsData)
    case failure(NewsData)
    
    struct NewsData {
        let imageUrl: String?
        let title: String?
        let description: String?
    }
}
