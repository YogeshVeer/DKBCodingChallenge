//
//  AlbumTableViewCell.swift
//  Albums
//
//  Created by Yogesh on 16.06.20.
//  Copyright © 2020 Yogesh. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var albumImageView: AsyncImageView!
    
    func updateCell(with album: Album) {
        nameLabel.text = album.title
        albumImageView.loadImage(urlString: album.thumbnailUrl)
    }

}
