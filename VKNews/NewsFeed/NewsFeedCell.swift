//
//  NewsFeedCell.swift
//  VKNews
//
//  Created by Yurii Sameliuk on 24/10/2020.
//

import UIKit

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
}
