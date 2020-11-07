//
//  NewsFeedCellLayoutCalculator.swift
//  VKNews
//
//  Created by Yurii Sameliuk on 28/10/2020.
//

import UIKit

struct Sizes: FeedCellSizes {
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
    var postLabelFrame: CGRect
    var moreTextButtonFrame: CGRect
    var attachementFrame: CGRect
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachements: [FeedCellPhotoAttachementViewModel], isFullSizedPost: Bool) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    private let screenWigth: CGFloat
    
    init(screenWigth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWigth = screenWigth
    }
    
    func sizes(postText: String?, photoAttachements: [FeedCellPhotoAttachementViewModel], isFullSizedPost: Bool) -> FeedCellSizes {
        
        var showMoreTextButton = false
        
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
            var height = text.height(width: width, font: Constants.postLabelFont)
            
            // nastrojka limita teksta pri kotorom bydet pokazana knopka razwernyt tekst
            let limitHeight = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitLines
            if !isFullSizedPost && height > limitHeight {
                height = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
                showMoreTextButton = true
            }
            
            postLabellFrame.size = CGSize(width: width, height: height)
        }
        
        //MARK: - Works with moreTextButtonFrame
        
        var moreTextButtonSize = CGSize.zero
        if showMoreTextButton {
            moreTextButtonSize = Constants.moreTextButtonSize
        }
        
        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInsets.left, y: postLabellFrame.maxY)
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        
        //MARK: - Works with Attachmentframe
        // esli y postLabellFrame razmer = 0 to AttachmentTop zanimaet pozicujy srazy pod topView wmesto  postLabellFrame
        let attachmentTop = postLabellFrame.size == CGSize.zero ? Constants.postLabelInserts.top : moreTextButtonFrame.maxY + Constants.postLabelInserts.bottom
        var attachmentframe = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: CGSize.zero)
        // esli k nam prishla fotografija
        //        if let attachment = photoAttachements {
        //            // priwodim k tipy Float 4tobu poly4it bolee to4nue zna4enija , a ne 1 i 0 kak pri Int
        //            print(attachment.width, attachment.height)
        //            let photoHeight: Float = Float(attachment.height)
        //            let photoWeigth: Float = Float(attachment.width)
        // otnoshenie wusotu k shurune(sootnoshenie storon)
        //   let ratio = CGFloat(photoHeight / photoWeigth)
        //   attachmentframe.size = CGSize(width: cardViewWigth, height: cardViewWigth * ratio)
        //}
        
        if let attachment = photoAttachements.first {
            let photoHeight: Float = Float(attachment.height)
            let photoWeigth: Float = Float(attachment.width)
            //otnoshenie wusotu k shurune(sootnoshenie storon)
            let ratio = CGFloat(photoHeight / photoWeigth)
            if photoAttachements.count == 1 {
                attachmentframe.size = CGSize(width: cardViewWigth, height: cardViewWigth * ratio)
            } else if photoAttachements.count > 1 {
                attachmentframe.size = CGSize(width: cardViewWigth, height: cardViewWigth * ratio)
            }
        }
        
        //MARK: - Works with BottonViewFrame
        // opredeliaem top granicy bottonView
        let bottomViewTop = max(postLabellFrame.maxY, attachmentframe.maxY)
        // opredeliaem polozenie bottomView
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop), size: CGSize(width: cardViewWigth, height: Constants.bottomViewHeight))
        
        //MARK: - Works with TotalHeight
        let totalHeight = bottomViewFrame.maxY + Constants.cardInserts.bottom
        
        return Sizes(bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight,
                     postLabelFrame: postLabellFrame,
                     moreTextButtonFrame: moreTextButtonFrame,
                     attachementFrame: attachmentframe)
    }
    
}

