//
//  MainView.swift
//  TochkaTask
//
//  Created by Mihail Tumakov on 08.02.2021.
//

import UIKit

class MainView: UIView {
    var viewData: ViewData = .initial {
        didSet {
            setNeedsLayout()
        }
    }
    
    lazy var tableView = makeTableView()
    lazy var activityIndicator = makeActivityIndicatorView()
    weak var delegate: ViewControllerDelegate?
    var articles: [ArticleMO] = []
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .yellow
        switch viewData {
        case .initial:
            update(viewData: nil, isHidden: true)
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            break
        case .success(let success):
            update(viewData: success, isHidden: false)
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            break
        case .failure:
            update(viewData: nil, isHidden: false)
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            break
        }
    }
    
    private func update(viewData: [ArticleMO]?, isHidden: Bool) {
        if let data = viewData {
            self.articles = data
            tableView.reloadData()
        }
    }
}
