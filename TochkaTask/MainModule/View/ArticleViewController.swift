//
//  ArticleViewController.swift
//  TochkaTask
//
//  Created by Mihail Tumakov on 19.02.2021.
//

import UIKit

protocol ArticleViewControllerDelegate: class {
    func dismissView()
}

class ArticleViewController: UIViewController, ArticleViewControllerDelegate {
    private var article: ArticleMO?
    private var articleView: ArticleView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.article = nil
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.article = nil
        super.init(coder: aDecoder)
    }
    
    init(article: ArticleMO) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createView()
    }
    
    private func createView() {
        articleView = ArticleView()
        articleView.frame = CGRect.init(origin: .zero, size: self.view.frame.size)
        articleView.delegate = self
        articleView.titleView.text = article?.title
        articleView.contentView.text = article?.desc
        articleView.image.downloaded(from: article?.urlToImage)
        
        view.addSubview(articleView)
    }
    
    func dismissView() {
        self.dismiss(animated: true)
    }
}
