//
//  NewsFeedInteractor.swift
//  VKNews
//
//  Created by Yurii Sameliuk on 21/10/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
  func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {

  var presenter: NewsFeedPresentationLogic?
  var service: NewsFeedService?
  
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
    }
    
    switch request {
    case .getNewsFeed:
        fetcher.getFeed { [weak self] (feedResponse) in
            
            feedResponse?.groups.map({ (profile)  in
                print(profile)
            })
            
            guard let feedResponse = feedResponse else { return }
            self?.presenter?.presentData(response: .presentNewsFeed(feed: feedResponse))
        }
    }
  }
  
}
