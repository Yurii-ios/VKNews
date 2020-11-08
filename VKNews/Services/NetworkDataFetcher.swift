//
//  NetworkDataFetcher.swift
//  VKNews
//
//  Created by Yurii Sameliuk on 20/10/2020.
//

import Foundation

// preobrazowuwaem Json dannue w nyznuj format
protocol DataFetcher  {
    func getFeed(response: @escaping (FeedResponse?) -> Void)
    
    func getUser(response: @escaping (UserResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher  {

    let networking: Networking
    
    private let authService: AuthService
    
    init(networking: Networking, authService: AuthService = SceneDelegate.shared().authServices) {
        self.networking = networking
        self.authService = authService
    }
    
    // poly4aem dannue samogo polzowatilia
    func getUser(response: @escaping (UserResponse?) -> Void) {
        guard let userId = authService.userid else { return }
        
        let params = ["user_ids": userId,"fields": "photo_100"]
        
        networking.request(path: API.user, params: params) { (data, error) in
            if let error = error {
                print("Error data:\(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: UserResponseWrapped.self, from: data)
            response(decoded?.response.first)
        }
    }
    
    func getFeed(response: @escaping (FeedResponse?) -> Void) {
        let params = ["filters": "post, photo"]
        networking.request(path: API.newsFeed, params: params) { (data, error) in
            if let error = error {
                print("Error data:\(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        
        return response
    }
}
