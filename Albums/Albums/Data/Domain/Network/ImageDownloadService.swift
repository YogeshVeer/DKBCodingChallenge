//
//  ImageDownloadService.swift
//  Albums
//
//  Created by Yogesh on 16.06.20.
//  Copyright © 2020 Yogesh. All rights reserved.
//

import Foundation

final class ImageDownloadService {
    
    private static func getData(url: URL,
                                completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
        
    public static func downloadImage(url: URL,
                                     completion: @escaping (Result<Data, Error>) -> Void) {
        ImageDownloadService.getData(url: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async() {
                completion(.success(data))
            }
        }
    }
}
