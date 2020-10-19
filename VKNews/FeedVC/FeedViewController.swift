//
//  FeedViewController.swift
//  VKNews
//
//  Created by Yurii Sameliuk on 19/10/2020.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        networkService.getFeed()
    }
}
