//
//  AlbumListViewModel.swift
//  Albums
//
//  Created by Yogesh on 16.06.20.
//  Copyright © 2020 Yogesh. All rights reserved.
//

import Foundation


enum ListViewState {
    case loading
    case loaded
    case error(APIError)
}


protocol AlbumListInput {
    func viewDidLoad()
    func didSelect(at indexpath: IndexPath)
}

protocol AlbumListOutput {
     var state: ListViewState { get }
}

final class AlbumListViewModel: AlbumListOutput {
    @Published private(set) var state: ListViewState = .loading
    
    var albums = [Album]()
    let apiService: AlbumsProvider
    weak var coordinator: MainCoordinator?

    
    @discardableResult
    init(service: AlbumsProvider) {
        self.apiService = service
    }
    
    func numberOfRows() -> Int {
        return albums.count
    }
    
    
    func value(forIndexpath indexpath: IndexPath) -> Album {
        return albums[indexpath.row]
    }
    
    func fetchData() {
        apiService.getAlbums { [weak self] (result) in
            switch result {
            case .success(let albumList) :
                self?.albums = albumList.albums
                self?.state = .loaded
            case .failure(let error):
                self?.state = .error(error)
            }
        }
    }
}

extension AlbumListViewModel: AlbumListInput {
    func viewDidLoad() {
        fetchData()
    }
        
    func didSelect(at indexpath: IndexPath) {
        let model = value(forIndexpath: indexpath)
        coordinator?.showDetail(withAlbum: model)
    }

}
