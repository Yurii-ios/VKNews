//
//  NewsFeedCellLayoutCalculator.swift
//  VKNews
//
//  Created by Yurii Sameliuk on 28/10/2020.
//

import UIKit

struct Sizes: FeedCellSizes {
    var bottonViewFrame: CGRect
    var totalHeight: CGFloat
    var postLabelFrame: CGRect
    var attachementFrame: CGRect
}
// ystanawliwaem granicu CardView
struct Constants {
    static let cardInserts = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    // wusota TopView
    static let topViewHeidht: CGFloat = 36
    //ystanawliwaem polozenie TopView w CardView
    static let postLabelInserts = UIEdgeInsets(top: 8 + Constants.topViewHeidht + 8, left: 8, bottom: 8, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    static let bottomViewHeight: CGFloat = 44
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachement: FeedCellPhotoAttachementViewModel?) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    private let screenWigth: CGFloat
    
    init(screenWigth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWigth = screenWigth
    }
    
    func sizes(postText: String?, photoAttachement: FeedCellPhotoAttachementViewModel?) -> FeedCellSizes {
        // wu4esliaem shuriny cardView
        let cardViewWigth = screenWigth - Constants.cardInserts.left - Constants.cardInserts.right

        //MARK: - Works with Labell Frame
        // ykazuwaem gde bydet raspologatsia nash postLabelFrame(opredeliae gde bydet raspologatsia lewuj werchnij ygol : x = 8, y = 52)
        var postLabellFrame = CGRect(origin: CGPoint(x: Constants.postLabelInserts.left, y: Constants.postLabelInserts.top), size: CGSize.zero)
        // rabotaem s razmerom postLabelFrame
        if let text = postText, !text.isEmpty {
            // otnimaem w cardView po x: 8 i po y: 8 pointow
            let width = cardViewWigth - Constants.postLabelInserts.left - Constants.postLabelInserts.right
            // ystanawliwaem wusoty postLabellFrame w zawisimosti ot kontenta s y4etom rasmera shrifta
            let height = text.height(width: width, font: Constants.postLabelFont)
            postLabellFrame.size = CGSize(width: width, height: height)
        }
        
        //MARK: - Works with Attachmentframe
        // esli y postLabellFrame razmer = 0 to AttachmentTop zanimaet pozicujy srazy pod topView wmesto  postLabellFrame
        let attachmentTop = postLabellFrame.size == CGSize.zero ? Constants.postLabelInserts.top : postLabellFrame.maxY + Constants.postLabelInserts.bottom
        var attachmentframe = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: CGSize.zero)
        // esli k nam prishla fotografija
        if let attachment = photoAttachement {
            // priwodim k tipy Float 4tobu poly4it bolee to4nue zna4enija , a ne 1 i 0 kak pri Int
            print(attachment.width, attachment.height)
            let photoHeight: Float = Float(attachment.height)
            let photoWeigth: Float = Float(attachment.width)
            // otnoshenie wusotu k shurune(sootnoshenie storon)
            let ratio = CGFloat(photoHeight / photoWeigth)
            attachmentframe.size = CGSize(width: cardViewWigth, height: cardViewWigth * ratio)
        }
        
        //MARK: - Works with BottonViewFrame
        // opredeliaem top granicy bottonView
        let bottomViewTop = max(postLabellFrame.maxY, attachmentframe.maxY)
        // opredeliaem polozenie bottomView
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop), size: CGSize(width: cardViewWigth, height: Constants.bottomViewHeight))
        
        //MARK: - Works with TotalHeight
        let totalHeight = bottomViewFrame.maxY + Constants.cardInserts.bottom
        
        return Sizes(bottonViewFrame: bottomViewFrame,
                     totalHeight: totalHeight,
                     postLabelFrame: postLabellFrame,
                     attachementFrame: attachmentframe)
    }
    
}
