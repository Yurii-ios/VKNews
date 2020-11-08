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
    
    private var feedResponse: FeedResponse?
  
    private var revealPostIds = [Int]()
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
    }
    
    switch request {
    case .getNewsFeed:
        fetcher.getFeed { [weak self] (feedResponse) in
            
//            feedResponse?.groups.map({ (profile)  in
//                print(profile)
//            })
            self?.feedResponse = feedResponse
            
            
            self?.presentFeed()
        }
    case .revealPostIds(let postId):
        // peredaem poly4enui Id postow w masiw, i etot masiw mu bydem peredavat kak parametr w presenter
         revealPostIds.append(postId)
        print(revealPostIds)
        presentFeed()
    case .getUser:
        fetcher.getUser { (userResponse) in
            self.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentUserInfo(user: userResponse))
        }
    }
  }
    
    private func presentFeed() {
        guard let feedResponse = feedResponse else { return }
        presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feedResponse, revealPostIds: revealPostIds))
    }
  
}
