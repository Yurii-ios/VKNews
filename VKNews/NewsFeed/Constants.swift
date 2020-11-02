//
//  Constants.swift
//  VKNews
//
//  Created by Yurii Sameliuk on 01/11/2020.
//

import UIKit
// ystanawliwaem granicu CardView
struct Constants {
    static let cardInserts = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    // wusota TopView
    static let topViewHeidht: CGFloat = 36
    //ystanawliwaem polozenie TopView w CardView
    static let postLabelInserts = UIEdgeInsets(top: 8 + Constants.topViewHeidht + 8, left: 8, bottom: 8, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    static let bottomViewHeight: CGFloat = 44
    static let bottomViewViewHeight: CGFloat = 44
    static let bottomViewViewWidth: CGFloat = 80
    static let bottomViewViewsIconSize: CGFloat = 24
    static let minifiedPostLimitLines: CGFloat = 8
    static let minifiedPostLines: CGFloat = 6
    static let moreTextButtonSize = CGSize(width: 170, height: 30)
    static let moreTextButtonInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    
}
