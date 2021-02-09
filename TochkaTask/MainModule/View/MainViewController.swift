//
//  ViewController.swift
//  TochkaTask
//
//  Created by Mihail Tumakov on 07.02.2021.
//

import UIKit

class MainViewController: UIViewController {
    private var viewModel: NewsViewModelProtocol!
    private var tableView: MainView!
    
    override func viewDidLoad() {
        viewModel = NewsViewModel()
        super.viewDidLoad()
        createView()
        updateView()
    }

    private func createView() {
        viewModel.startFetch()
        tableView = MainView()
        tableView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        tableView.center = view.center
        view.addSubview(tableView)
    }
    
    private func updateView() {
        viewModel.updateViewData = { [weak self] viewData in
            self?.tableView.viewData = viewData
        }
    }
    
    
}

