//
//  SearchCVC.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/21/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

class SearchCVC: UICollectionViewCell {
    
    static let cellIdentifier = "searchCell"

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = #colorLiteral(red: 0, green: 0.7176470588, blue: 0.7921568627, alpha: 1)
        self.layer.borderWidth = 2
    }
    
    func configure(with item: SearchItemVM) {
        titleLabel.text = item.title
        imageView.loadImage(urlString: item.image ?? "")
        self.contentView.backgroundColor = item.isSeen ? #colorLiteral(red: 0, green: 0.7176470588, blue: 0.7921568627, alpha: 0.2744278169) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if UIDevice.current.userInterfaceIdiom == .pad {
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 1
            return
        }
        titleLabel.textAlignment = UIDevice.current.orientation.isPortrait ? .left : .center
        titleLabel.numberOfLines = UIDevice.current.orientation.isPortrait ? 2 : 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

}
