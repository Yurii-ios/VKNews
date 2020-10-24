//
//  NewsFeedPresenter.swift
//  VKNews
//
//  Created by Yurii Sameliuk on 21/10/2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
    func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
    weak var viewController: NewsFeedDisplayLogic?
    
    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        switch response {
        case .presentNewsFeed(feed: let feed):
            let cells = feed.items.map { (feedItem)  in
                cellViewModel(feedItem: feedItem)
            }
            
            let feedViewModel = FeedViewModel(cells: cells)
            viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
        }
    }
    
    private func cellViewModel(feedItem: FeedItem) -> FeedViewModel.Cell {
        return FeedViewModel.Cell.init(
            iconUrlString: "",
            name: "",
            date: "feedItem.date",
            text: feedItem.text,
            likes: String(feedItem.likes?.count ?? 0),
            comments: String(feedItem.comments?.count ?? 0),
            shares: String(feedItem.reposts?.count ?? 0),
            views: String(feedItem.views?.count ?? 0))
    }
    
}
