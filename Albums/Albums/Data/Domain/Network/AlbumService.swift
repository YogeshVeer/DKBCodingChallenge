//
//  AlbumService.swift
//  Albums
//
//  Created by Yogesh on 16.06.20.
//  Copyright © 2020 Yogesh. All rights reserved.
//

import Foundation

enum APIError: Error {
    case internalError
    case serverError
    case parsingError
}

protocol AlbumsProvider {
    func getAlbums(completion: @escaping ((Result<AlbumsList,APIError>)-> Void))
}

// https://jsonplaceholder.typicode.com/photos
class AlbumsAPI: AlbumsProvider {
    private let baseUrl = "https://jsonplaceholder.typicode.com/"
    
    private enum Endpoint: String {
        case products = "photos"
    }
    
    private enum Method: String {
        case GET
    }
    
    func getAlbums(completion: @escaping ((Result<AlbumsList, APIError>) -> Void)) {
        request(endpoint: .products, method: .GET, completion: completion)
    }
    
    private func request<T: Codable>(endpoint: Endpoint, method: Method, completion: @escaping(Result<T,APIError>)-> Void) {
        let path = "\(baseUrl)\(endpoint.rawValue)"
        guard let url = URL(string: path) else {
            completion(.failure(.internalError))
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        request.httpMethod = "\(method)"
        call(request: request, completion: completion)
    }
    
    private func call<T: Codable>(request: URLRequest, completion: @escaping ((Result<T,APIError>) -> Void)) {
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.serverError))
                return
            }
            
            do {
                guard let data = data else {
                    completion(.failure(.serverError))
                    return
                }
                let jsonDecoder = JSONDecoder()
                let model = try jsonDecoder.decode(T.self, from: data)
                completion(.success(model))
            } catch let error  {
                print(error)
                completion(.failure(.parsingError))
            }
        }
        dataTask.resume()
    }
}
