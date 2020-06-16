//
//  AlbumsList.swift
//  Albums
//
//  Created by Yogesh on 16.06.20.
//  Copyright © 2020 Yogesh. All rights reserved.
//

import Foundation

struct AlbumsList {
    let albums: [Album]
}

extension AlbumsList: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        albums = try container.decode([Album].self)
    }
}
