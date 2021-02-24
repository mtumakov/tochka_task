//
//  DetailedViewController.swift
//  TochkaTask
//
//  Created by Mihail Tumakov on 23.02.2021.
//


import UIKit


class ArticleViewController: UIViewController {
    let article: ArticleMO?
    
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
    
    var returnButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        button.setTitle("Назад", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(returnButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        overrideUserInterfaceStyle = .dark
        setupUI()
    }
    
    func setupUI() {
        let scrollView = UIScrollView()
        let imageView = UIView()
        let titleView = UILabel()
        let contentView = UILabel()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        view.addSubview(returnButton)
        
        [imageView, titleView, contentView, returnButton].forEach { scrollView.addSubview($0) }
        scrollView.bringSubviewToFront(returnButton)
        
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 16),
            titleView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -16),
            titleView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 150)
        ])
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -16),
            imageView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 16)
        ])
        
        if article?.urlToImage == nil {
            imageView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        } else {
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        }
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -16),
            contentView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -100)
        ])
        
        returnButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        returnButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 70).isActive = true
        
        titleView.textAlignment = .natural
        titleView.textColor = .white
        titleView.font = UIFont.boldSystemFont(ofSize: 26)
    
        titleView.text = article?.title
        titleView.numberOfLines = 0
        
        contentView.textAlignment = .natural
        contentView.textColor = .white
        contentView.font = UIFont.systemFont(ofSize: 20)
        contentView.text = article?.desc
        contentView.numberOfLines = 0
        
        if let imageLink = article?.urlToImage {
            print("image link - \(imageLink)")
            let image = UIImageView()
            imageView.addSubview(image)
            image.downloaded(from: imageLink, contentMode: .scaleAspectFill)
            image.fillSuperview()
            image.alignmentRect(forFrame: imageView.frame)
        }
    }
    
    @objc func returnButtonTapped(sender: Any) {
        self.dismiss(animated: true)
    }
}

extension UIView {
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat? = 0, paddingLeft: CGFloat? = 0, paddingBottom: CGFloat? = 0, paddingRight: CGFloat? = 0, width: CGFloat? = nil, height: CGFloat? = nil)  {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
        }
        
        if let right = right {
            if let paddingRight = paddingRight {
                rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
        }
        
        if let bottom = bottom {
            if let paddingBottom = paddingBottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func fillSuperview() {
        anchor(top: superview?.topAnchor, left: superview?.leftAnchor, bottom: superview?.bottomAnchor, right: superview?.rightAnchor)
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String?, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let link = link else {
            return
        }
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
