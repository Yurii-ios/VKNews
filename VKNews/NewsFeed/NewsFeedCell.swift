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
    var photoAttachement: FeedCellPhotoAttachementViewModel? { get }
}
protocol FeedCellPhotoAttachementViewModel {
    var photoUrlString: String? { get }
    var width: Int { get }
    var height: Int { get }
}

class NewsFeedCell: UITableViewCell {
    // identifikator dlia registracii ja4ejki
    static let reuseId = "NewsFeedCell"
    
    @IBOutlet var iconImageView: WebImageView!
    @IBOutlet var postImageView: WebImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var cardView: UIView!
    @IBOutlet var postLabel: UILabel!
    
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var shareLabel: UILabel!
    @IBOutlet var viewsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.clipsToBounds = true
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        backgroundColor = .clear
        
        selectionStyle = .none
    }
    
    func set(viewModel: FeedCellViewModel) {
        iconImageView.set(imageURL: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        textLabel?.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        shareLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        if let photoAttachement = viewModel.photoAttachement {
            postImageView.set(imageURL: photoAttachement.photoUrlString)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
    }
}
