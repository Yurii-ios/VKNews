//
//  NewsFeedCell.swift
//  VKNews
//
//  Created by Yurii Sameliuk on 24/10/2020.
//

import UIKit
// sozdaem protocol dlia pereda4i dannuch w autletu
protocol FeedCellViewModel {
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
}

class NewsFeedCell: UITableViewCell {
    // identifikator dlia registracii ja4ejki
    static let reuseId = "NewsFeedCell"
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var postLabel: UILabel!
    
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var shareLabel: UILabel!
    @IBOutlet var viewsLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func set(viewModel: FeedCellViewModel) {
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        textLabel?.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        shareLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
    }
}
