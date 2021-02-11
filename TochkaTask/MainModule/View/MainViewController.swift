//
//  ViewController.swift
//  TochkaTask
//
//  Created by Mihail Tumakov on 07.02.2021.
//

import UIKit

class MainViewController: UIViewController {
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
        view.addSubview(mainView)
    }
    
    private func updateView() {
        viewModel.updateViewData = { [weak self] viewData in
            self?.mainView.viewData = viewData
        }
    }
}

