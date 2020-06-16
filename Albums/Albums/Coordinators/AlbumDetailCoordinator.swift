//
//  AlbumDetailCoordinator.swift
//  Albums
//
//  Created by Yogesh on 16.06.20.
//  Copyright © 2020 Yogesh. All rights reserved.
//

import Foundation

class AlbumDetailCoordinator: AppCoordinator {
    var album: Album!
    
    override func start() {
        let viewController = AlbumDetailViewController.instantiate()
        viewController.viewModel = makeViewModel(withAlbum: album)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func makeViewModel(withAlbum album: Album) -> AlbumDetailViewModel {
        return AlbumDetailViewModel(withAlbum: album)
    }

    
    func didFinishDetail() {
        parentCoordinator?.didFinish(coordinator: self)
    }

}
