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
    
  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
    }
    
    switch request {
    case .getNewsFeed:
        service?.getFeed(completion: { [weak self](revealPostIds, feed) in
            self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, revealPostIds: revealPostIds))
        })
    case .getUser:
        service?.getUser(completion: { [weak self](user) in
            self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentUserInfo(user: user))
        })
    case .revealPostIds(postId: let postId):
        service?.revealPostIds(forPostId: postId, completion: { [weak self] (revealPostIds, feed) in
            self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, revealPostIds: revealPostIds))
        })
    case .getNextBatch:
        service?.getNextBatch(completion: { [weak self] (revealPostIds, feed) in
            self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, revealPostIds: revealPostIds))
        })
    }
  }
}
