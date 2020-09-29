//
//  XibView.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/23/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

class XibView: UIView {

    func load(nibName: String) {
        if let view = Bundle.init(for: type(of: self)).loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
            
            let topConstraint = view.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
            let trailingConstraint = view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
            let bottomConstraint = view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
            let leadingConstraint = view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
            
            topConstraint.isActive = true
            trailingConstraint.isActive = true
            bottomConstraint.isActive = true
            leadingConstraint.isActive = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.load(nibName: "\(self.classForCoder)")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.load(nibName: "\(self.classForCoder)")
    }
}
