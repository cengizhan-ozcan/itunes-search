//
//  OptionTVC.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/21/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

class OptionTVC: UITableViewCell {
    
    static let cellIdentifier = "optionCell"
    
    @IBOutlet private weak var selectedBoxView: UIView!
    @IBOutlet private weak var innerSelectedBoxView: UIView!
    @IBOutlet private weak var optionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBoxView.layer.cornerRadius = selectedBoxView.frame.height / 2
        selectedBoxView.layer.borderColor = #colorLiteral(red: 0, green: 0.7176470588, blue: 0.7921568627, alpha: 1)
        selectedBoxView.layer.borderWidth = 1
        innerSelectedBoxView.layer.cornerRadius = innerSelectedBoxView.frame.height / 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(option: String, isSelected: Bool) {
        innerSelectedBoxView.backgroundColor = isSelected ? #colorLiteral(red: 0, green: 0.7176470588, blue: 0.7921568627, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        optionLabel.text = option
    }

    
}
