//
//  MainCoordinator.swift
//  Albums
//
//  Created by Yogesh on 16.06.20.
//  Copyright © 2020 Yogesh. All rights reserved.
//

import UIKit

class MainCoordinator: AppCoordinator {
    
    override func start() {
        let viewController = AlbumsListViewController.instantiate()
        viewController.viewModel = makeViewModel()
        viewController.viewModel.coordinator = self
        self.navigationController.pushViewController(viewController, animated: false)
    }

    func makeViewModel() -> AlbumListViewModel {
        return AlbumListViewModel(service: makeService())
    }

    func makeService() -> AlbumsProvider {
        return AlbumsAPI()
    }

    func showDetail(withAlbum album: Album) {
        let coordinator = AlbumDetailCoordinator(with: self.navigationController)
        coordinator.album = album
        self.start(with: coordinator)
    }

}

