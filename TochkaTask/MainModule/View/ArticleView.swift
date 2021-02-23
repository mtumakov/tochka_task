//
//  ArticleView.swift
//  TochkaTask
//
//  Created by Mihail Tumakov on 19.02.2021.
//

import UIKit

class ArticleView: UIScrollView {
    lazy var contentView = makeContentView()
    lazy var backButton = makeBackButton()
    lazy var imageView = makeImageView()
    lazy var titleView = makeTitleView()
    
    weak var avcDelegate: ArticleViewControllerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backButton.addTarget(self, action: #selector(returnButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func returnButtonTapped(_ sender: Any) {
        avcDelegate?.dismissView()
    }
}
