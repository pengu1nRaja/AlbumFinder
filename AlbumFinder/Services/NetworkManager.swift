//
//  NetworkManager.swift
//  AlbumFinder
//
//  Created by PenguinRaja on 19.09.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: String?, with completion: @escaping (SearchResponse?) -> Void) {
        
        let stringURL = "https://itunes.apple.com/search?term=\(url ?? "")&attribute=albumTerm&country=ru"
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                completion(nil)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(searchResponse)
                }
            } catch let error {
                print(error)
                completion(nil)
            }
        }.resume()
    }
    
    func fetchAlbumDetails(from url: Int, with completion: @escaping (SearchResponse?) -> Void) {
        
        let stringURL = "https://itunes.apple.com/lookup?id=\(url)&entity=song&country=ru"
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                completion(nil)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(searchResponse)
                }
            } catch let error {
                print(error)
                completion(nil)
            }
        }.resume()
    }
}
