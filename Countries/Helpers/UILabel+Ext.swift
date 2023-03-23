//
//  UILabel+Ext.swift
//  Countries
//
//  Created by Ömer Karabulut on 23.03.2023.
//

import UIKit

extension UILabel {
    func halfTextFontChange (fullText : String , changeText : String ) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 16) , range: range)
        self.attributedText = attribute
    }
}
