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
        
        var urlComponents: URLComponents? {
            switch self {
            case .search(let query):
                return URLComponents(string: "https://itunes.apple.com/search/media=music&entity=album&term=\(query)")
            }
        }
    }
    
    // MARK: - Public Methods
    
    static func request(album: String, completion: @escaping (AlbumResult?, Error?) -> Void) {
        request(endpoint: .search(album), completion: completion)
    }
    
    // MARK: - Private Methods
    
    /// Generic request method
    private static func request<T: Decodable>(endpoint: EndPoint, completion: @escaping (T?, Error?) -> Void) {
        DispatchQueue.global().async {
            guard let urlComponents = endpoint.urlComponents else { return }
            guard let url = urlComponents.url else { return }
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("Error: \(String(describing: error))")
                    return
                }
                
                guard let data = data else { return print("NO DATA") }
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let object = try jsonDecoder.decode(T.self, from: data)
                    DispatchQueue.main.async { completion(object, nil) }
                } catch {
                    DispatchQueue.main.async { completion(nil, error) }
                    print("Error: \(String(describing: error))")
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }
}
