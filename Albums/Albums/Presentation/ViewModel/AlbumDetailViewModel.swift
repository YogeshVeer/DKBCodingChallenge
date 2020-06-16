//
//  AlbumDetailViewModel.swift
//  Albums
//
//  Created by Yogesh on 16.06.20.
//  Copyright © 2020 Yogesh. All rights reserved.
//

import Foundation

final class AlbumDetailViewModel {
    
    var album: Album
    
    weak var coordinator: AlbumDetailCoordinator?

    init(withAlbum album: Album) {
        self.album = album
    }
    
    var imageUrl: String {
        return album.url
    }

}
