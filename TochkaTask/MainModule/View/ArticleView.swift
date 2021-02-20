//
//  ArticleView.swift
//  TochkaTask
//
//  Created by Mihail Tumakov on 19.02.2021.
//

import UIKit

class ArticleView: UIView {
    lazy var contentView = makeContentView()
    lazy var scrollView = makeScrollView()
    lazy var backButton = makeBackButton()
    lazy var imageView = makeImageView()
    lazy var titleView = makeTitleView()
    lazy var image = makeImage()
    
    weak var delegate: ArticleViewControllerDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backButton.addTarget(self, action: #selector(returnButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func returnButtonTapped(_ sender: Any) {
        delegate?.dismissView()
    }
}
