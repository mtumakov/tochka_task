//
//  ArticleView + Extension.swift
//  TochkaTask
//
//  Created by Mihail Tumakov on 19.02.2021.
//

import UIKit

extension ArticleView {
    func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        addSubview(scrollView)
        scrollView.backgroundColor = .yellow
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        return scrollView
    }
    
    func makeBackButton() -> UIButton {
        let button = UIButton()
        addSubview(button)
        bringSubviewToFront(button)
        button.setTitle("Назад", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -130).isActive = true
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        return button
    }
    
    func makeTitleView() -> UILabel {
        let titleLabel = makeLabel(size: 26)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center

        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        return titleLabel
    }
    
    func makeContentView() -> UILabel {
        let contentLabel = makeLabel(size: 18)
        contentLabel.font = UIFont.systemFont(ofSize: 18)
        contentLabel.numberOfLines = 0
        contentLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 12).isActive = true
        contentLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        return contentLabel
    }
    
    func makeLabel(size: CGFloat) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.backgroundColor = .red
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: size)
        scrollView.addSubview(label)
        return label
    }
    
    func makeImageView() -> UIView {
        let imageView = UIView()
        scrollView.addSubview(imageView)
        imageView.sizeToFit()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 12).isActive = true
        imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        return imageView
    }
    
    func makeImage() -> UIImageView {
        let image = UIImageView()
        imageView.addSubview(image)
        image.frame = CGRect.init(origin: .zero, size: imageView.frame.size)
        return image
    }
}

extension UIImageView {
    func downloaded(from url: URL?, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        
        guard url != nil else {
            return
        }
        contentMode = mode
        URLSession.shared.dataTask(with: url!) { data, response, error in
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
