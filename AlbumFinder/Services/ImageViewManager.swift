//
//  ImageViewManager.swift
//  AlbumFinder
//
//  Created by PenguinRaja on 19.09.2021.
//

import UIKit

class ImageManager {
    
    static var shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping (Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            guard url == response.url else { return }
            completion(data, response)
        }.resume()
    }
}

class ImageViewManager: UIImageView {
    
    func fetchImage(from url: String) {
        guard let imageURL = URL(string: url) else {
            image = UIImage(named: "music.note")
            return
        }
        
        if let cachedImage = getCachedImage(from: imageURL) {
            image = cachedImage
            return
        }
        
        ImageManager.shared.fetchImage(from: imageURL) { (data, response) in
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            self.saveDataToCache(data: data, response: response)
        }
    }
    
    private func getCachedImage(from url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
    
    private func saveDataToCache(data: Data, response: URLResponse) {
        guard let urlResponse = response.url else { return }
        let urlRequest = URLRequest(url: urlResponse)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }

}
