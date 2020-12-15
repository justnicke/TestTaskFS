//
//  API.swift
//  TestTaskFS
//
//  Created by Nikita Sukachev on 10.12.2020.
//

import Foundation

final class API {
    
    // MARK: - Private Nested
    
    private enum EndPoint {
        case search(_ album: String)
        case albumTracks(_ id: String)
        
        var urlComponents: URLComponents? {
            switch self {
            case .search(let query):
                return URLComponents(string: "https://itunes.apple.com/search/media=music&entity=album&term=\(query)")
            case .albumTracks(let id):
                return URLComponents(string: "https://itunes.apple.com/lookup?entity=song&id=\(id)")
            }
        }
    }
    
    // MARK: - Public Methods
    
    static func request(album: String, completion: @escaping (Result<AlbumResult, Error>) -> Void) {
        request(endpoint: .search(album), completion: completion)
    }
    
    static func request(albumTracks: String, completion: @escaping (Result<TrackResult, Error>) -> Void) {
        request(endpoint: .albumTracks(albumTracks), completion: completion)
    }
    
    // MARK: - Private Methods
    
    /// Generic request method
    private static func request<T: Decodable>(endpoint: EndPoint, completion: @escaping (Result<T, Error>) -> Void) {
        DispatchQueue.global().async {
            guard let urlComponents = endpoint.urlComponents else { return }
            guard let url = urlComponents.url else { return }
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard error == nil else {
                    print("Error: \(String(describing: error))")
                    return
                }
                
                guard let data = data else { return print("No Data") }
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let object = try jsonDecoder.decode(T.self, from: data)
                    DispatchQueue.main.async { completion(.success(object)) }
                } catch {
                    DispatchQueue.main.async { completion(.failure(error)) }
                    print("Error: \(error.localizedDescription)")
                }
            }
            task.resume()
        }
    }
}
