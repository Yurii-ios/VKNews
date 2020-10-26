//
//  WebImageView.swift
//  VKNews
//
//  Created by Yurii Sameliuk on 26/10/2020.
//

import UIKit

class WebImageView: UIImageView {
    func set(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        
        // proweriaem zagryzenu li izobrazenija
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage.init(data: cachedResponse.data)
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.image = UIImage(data: data)
                    // peredaem zagryzenue foto v kesh
                    self?.handleLoadedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }
    // keshuryem foto
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseUrl = response.url else { return }
        let cacheResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cacheResponse, for: URLRequest(url: responseUrl))
    }
}
