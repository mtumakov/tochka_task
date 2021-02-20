//
//  CoreDataManager.swift
//  TochkaTask
//
//  Created by Mihail Tumakov on 11.02.2021.
//

import CoreData

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
    
    func saveArticle(id: Int, author: String?, description: String?, publishedAt: Date, title: String?, url: URL?, urlToImage: URL?) {
        
        let article = ArticleMO(context: moc)
        article.setValue(id, forKey: "id")
        article.setValue(title, forKey: "title")
        article.setValue(author, forKey: "author")
        article.setValue(description, forKey: "desc")
        article.setValue(publishedAt, forKey: "publishedAt")
        article.setValue(url, forKey: "url")
        article.setValue(urlToImage, forKey: "urlToImage")
        
        let fetchRequest = NSFetchRequest<ArticleMO>(entityName: "ArticleMO")
        let predicate = NSPredicate.init(format: "id == %d", id)
        fetchRequest.predicate = predicate
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "ArticleMO", in: moc)
        
        do {
            let arrData = try moc.fetch(fetchRequest)
            if arrData.isEmpty {
                try moc.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchArticles() -> [ArticleMO] {
        print("Fetch articles from db")
        do {
            let fetchRequest = NSFetchRequest<ArticleMO>(entityName: "ArticleMO")
            let sortDesc = NSSortDescriptor(key: "publishedAt", ascending: false)
            fetchRequest.sortDescriptors = [sortDesc]
            let articles = try moc.fetch(fetchRequest)
            return articles
        } catch {
            print(error)
            return []
        }
    }
    
    func deleteArticles() {
        print("Delete articles")
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleMO")
        let fetchedResults: [NSManagedObject]?
        do {
            fetchedResults = try moc.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                
                for iter in results {
                    moc.delete(iter)
                }
            }
            try moc.save()
        } catch {
            print("Could not fetch: \(error)")
        }
    }
}
