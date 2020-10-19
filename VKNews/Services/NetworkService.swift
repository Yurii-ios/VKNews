//
//  NetworkService.swift
//  VKNews
//
//  Created by Yurii Sameliuk on 19/10/2020.
//

import Foundation

final class NetworkService {
    private let authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared().authServices) {
    self.authService = authService
    }
    
    func getFeed() {
        //URLComponents - pozwoliaet sozdawat URL iz sostawnuch 4astej
        var components = URLComponents()
        
        // https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.124
        guard let token = authService.token else { return }
        
        let params = ["filters": "post, photo"]
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        print(allParams)
        
        //https
        components.scheme = API.scheme
        //api.vk.com
        components.host = API.host
        // /method/users.get - k kakomy metody mu chotim obras4atsia
        components.path = API.newsFeed
        // ostalnoe w stroke zaprosa
        components.queryItems = allParams.map({ URLQueryItem(name: $0, value: $1)})
        
       let url = components.url!
        print(url)
    }
}
