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
        view.backgroundColor = .red
        createView()
    }
    
    private func createView() {
        articleView = ArticleView(frame:CGRect(x: 20, y: 20, width: view.frame.size.width - 40, height: view.frame.size.height - 40))
        articleView.backgroundColor = .green
        view.addSubview(articleView)
        articleView.translatesAutoresizingMaskIntoConstraints = false
        articleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        articleView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        articleView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        articleView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        
        articleView.avcDelegate = self

        articleView.titleView.text = article?.title
    }
    
    func dismissView() {
        self.dismiss(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
