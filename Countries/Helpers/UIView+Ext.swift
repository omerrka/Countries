//
//  UIView+Ext.swift
//  Countries
//
//  Created by Ömer Karabulut on 20.03.2023.
//

import UIKit

extension UIView {
    
    func pin(to superView: UIView) {
        
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 36).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -36).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}

