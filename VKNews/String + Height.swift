//
//  String + Height.swift
//  VKNews
//
//  Created by Yurii Sameliuk on 29/10/2020.
//

import UIKit

extension String {
    func height (width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        // func wu4esliaet i wozwras4aet ograni4enuj priamoygolnik y4ituwaja tekst i font
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                    context: nil)
        return ceil(size.height)// size.height zna4enie  nygno okruglit s pomos4ju func ceil()
    }
}
