//
//  ViewController.swift
//  TochkaTask
//
//  Created by Mihail Tumakov on 07.02.2021.
//

import UIKit

protocol ViewControllerDelegate: class {
    func nextPage()
    func openDetailedArticle(article: ArticleMO)
}

class MainViewController: UIViewController, ViewControllerDelegate {
    private var viewModel: NewsViewModelProtocol!
    private var mainView: MainView!
    
    override func viewDidLoad() {
        viewModel = NewsViewModel()
        super.viewDidLoad()
        createView()
        updateView()
    }

    private func createView() {
        viewModel.startFetch()
        mainView = MainView()
        mainView.frame = CGRect.init(origin: .zero, size: self.view.frame.size)
        mainView.delegate = self
        view.addSubview(mainView)
    }
    
    private func updateView() {
        viewModel.updateViewData = { [weak self] viewData in
            self?.mainView.viewData = viewData
        }
    }
    
    func nextPage() {
        viewModel.fetchNextPage()
    }
    
    func openDetailedArticle(article: ArticleMO) {
        let avc = ArticleViewController(article: article)
        present(avc, animated: true, completion: nil)
    }
}

