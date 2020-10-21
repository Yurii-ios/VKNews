//
//  NetworkService.swift
//  VKNews
//
//  Created by Yurii Sameliuk on 19/10/2020.
//

import Foundation

protocol Networking {
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: Networking {
    private let authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared().authServices) {
    self.authService = authService
    }
    
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }
        
        //let params = ["filters": "post, photo"]
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        let url = self.url(from: path, params: allParams)
        // sozdaem zapros
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        print(url)
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    private func url(from path: String, params: [String: String]) -> URL {
        //URLComponents - pozwoliaet sozdawat URL iz sostawnuch 4astej
        var components = URLComponents()
        //https
        components.scheme = API.scheme
        //api.vk.com
        components.host = API.host
        // /method/users.get - k kakomy metody mu chotim obras4atsia
        components.path = path
        // ostalnoe w stroke zaprosa
        components.queryItems = params.map({ URLQueryItem(name: $0, value: $1)})
        print(components.url!)
       return components.url!
        
    }
}
