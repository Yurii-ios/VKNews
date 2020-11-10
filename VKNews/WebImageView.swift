//
//  WebImageView.swift
//  VKNews
//
//  Created by Yurii Sameliuk on 26/10/2020.
//

import UIKit

class WebImageView: UIImageView {
    
    private var currentUrlString: String?
    
    func set(imageURL: String?) {
        currentUrlString = imageURL
        guard let imageURL = imageURL, let url = URL(string: imageURL) else { self.image = nil; return }
        
        // proweriaem zagryzenu li izobrazenija
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage.init(data: cachedResponse.data)
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            DispatchQueue.main.async {
                if let data = data, let response = response {
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
        
        //sowpadaet li ssulka na ety fotografijy s realnoj ssulkoj na ety fotografijy
        if responseUrl.absoluteString == currentUrlString {
            self.image = UIImage(data: data)
        }
    }
}
