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
}

struct NetworkDataFetcher: DataFetcher  {
    
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
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
