//
//  ViewController.swift
//  Albums
//
//  Created by Yogesh on 16.06.20.
//  Copyright © 2020 Yogesh. All rights reserved.
//

import UIKit
import Combine

class AlbumsListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var viewModel: AlbumListViewModel!
    private var bindings = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Albums"
        tableView.estimatedRowHeight = 100
        viewModel.viewDidLoad()
        bind(to: viewModel)
    }
    
    func bind(to viewModel: AlbumListViewModel) {
        let stateValueHandler: (ListViewState) -> Void = { [weak self] state in
            switch state {
//            case .loading:
                // show activity indicator
            case .loaded:
                self?.tableView.reloadData()
            default:
                print(state)
                //showError
            }
        }
        
        viewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &bindings)
    }
        
}

extension AlbumsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.value(forIndexpath: indexPath)
        let cell: AlbumTableViewCell = tableView.dequeReusableCell(for: indexPath)
        cell.updateCell(with: model)
        return cell
    }
}

extension AlbumsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(at: indexPath)
    }
}

