//
//  CoreDataManager.swift
//  TochkaTask
//
//  Created by Mihail Tumakov on 11.02.2021.
//

import CoreData
import UIKit

final class CoreDataManager {
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "TochkaTask")
        persistentContainer.loadPersistentStores{ _, error in
            print(error?.localizedDescription ?? "")
        }
        return persistentContainer
    }()
    
    var moc: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveArticle(author: String?, description: String?, publishedAt: Date?, title: String?, url: URL?, urlToImage: URL?, image: UIImage?) {
        
        let article = ArticleMO(context: moc)
        article.setValue(title, forKey: "title")
        article.setValue(author, forKey: "author")
        article.setValue(description, forKey: "desc")
        article.setValue(publishedAt, forKey: "publishedAt")
        article.setValue(url, forKey: "url")
        article.setValue(urlToImage, forKey: "urlToImage")
        if let image = image {
            let imageData = image.jpegData(compressionQuality: 1)
            article.setValue(imageData, forKey: "image")
        }
        
        do {
            try moc.save()
        } catch {
            print(error)
        }
    }
    
    func fetchArticles() -> [ArticleMO] {
        do {
            let fetchRequest = NSFetchRequest<ArticleMO>(entityName: "ArticleMO")
            let articles = try moc.fetch(fetchRequest)
            return articles
        } catch {
            print(error)
            return []
        }
    }
}
