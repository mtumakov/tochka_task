//
//  MainView + Extension.swift
//  TochkaTask
//
//  Created by Mihail Tumakov on 08.02.2021.
//

import UIKit

extension MainView: UITableViewDelegate, UITableViewDataSource {
    
    func makeActivityIndicatorView() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        activityIndicator.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 5).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        return activityIndicator
    }
    
    func makeTableView() -> UITableView {
        let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
        addSubview(tableView)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.estimatedRowHeight = CGFloat(40)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .green
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        return tableView
    }
    
    func makeTitleLabel() -> UILabel {
        let titleLabel = makeLabel(size: 20)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.backgroundColor = .blue
        titleLabel.textAlignment = .center
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        return titleLabel
    }
    
    func makeLabel(size: CGFloat) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: size)
        addSubview(label)
        return label
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Количество новостей в ленте - \(articles.count)")
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "TableViewCell")
        cell.textLabel!.font = UIFont.systemFont(ofSize: 18)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.backgroundColor = .green
        cell.accessoryType = .detailButton
        
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        cell.detailTextLabel?.backgroundColor = .yellow
        cell.detailTextLabel?.textColor = .black
        cell.detailTextLabel?.numberOfLines = 1

        let item = articles[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.publishedAt?.dateToString()
        return cell
    }
}

extension MainView {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastRow = indexPath.row
        if lastRow == articles.count - 1 {
            print("Go to next Page, articles count - \(articles.count)")
            delegate?.nextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.openDetailedArticle(article: articles[indexPath.row])
    }
}
