//
//  ItemDetailTVC.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/23/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

class ItemDetailTVC: UITableViewCell {
    
    static let cellIdentifier = "itemDetailCell"

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(item: SearchItemDetailVM) {
        titleLabel.text = item.title
        contentLabel.text = item.content
    }
}
