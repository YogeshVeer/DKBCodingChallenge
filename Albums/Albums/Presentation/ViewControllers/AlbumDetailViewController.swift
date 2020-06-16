//
//  AlbumDetailViewController.swift
//  Albums
//
//  Created by Yogesh on 16.06.20.
//  Copyright © 2020 Yogesh. All rights reserved.
//

import UIKit

class AlbumDetailViewController: UIViewController {

    @IBOutlet weak var albumImageView: AsyncImageView!
    var viewModel: AlbumDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        albumImageView.loadImage(urlString: viewModel.imageUrl)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.coordinator?.didFinishDetail()
    }
}
