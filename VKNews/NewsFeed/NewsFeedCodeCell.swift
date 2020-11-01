//
//  NewsFeedCodeCell.swift
//  VKNews
//
//  Created by Yurii Sameliuk on 01/11/2020.
//

import UIKit

final class NewsFeedCodeCell: UITableViewCell {
    
    static let reuseId = "NewsFeedCodeCell"
    
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(cardView)
        backgroundColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        
        // zakrepliaem cardView na ekrane:
        // 1 - NSLayoutConstraint - samuj staruj sposob
        // 2 - NSLayoutAnchor
        // 3 - Visual Format Language - samuj bustruj sposob , no pri sloznuch interfeisach kod bydet ne4utabelnuj
        // prikrepliaem werchnyjy granicy cardView k werchnej granice ja4ejki
//        cardView.topAnchor.constraint(equalTo: topAnchor,constant: 12).isActive = true
//        cardView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -12).isActive = true
//        cardView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -12).isActive = true
//        cardView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12).isActive = true
        //cardView.fillSuperview(padding: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
        //cardView.fillSuperview()
    
        // lewuj werchnij ygol
//        cardView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
//        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
//        cardView.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        cardView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        // polozenie w centre
//        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
//        cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
//        cardView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        cardView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //zanimaet rowno polowiny wusotu kazdoj ja4ejki
//        cardView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        cardView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        cardView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        cardView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/2).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
