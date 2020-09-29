//
//  OptionPopupPresenter.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/21/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

class OptionPopupPresenter: VPOptionPopupProtocol {
    
    weak var view: PVOptionPopupProtocol?
    var interactor: PIOptionPopupProtocol?
    var router: PROptionPopupProtocol?
    var delegate: OptionPopupModuleDelegate?
    
    var optionList: [String]!
    var selectedOption: String!
    var title: String!
    
    func onSelectOption(for option: String) {
        selectedOption = option
    }
    
    func onSelection() {
        delegate?.onSelected(option: selectedOption)
        router?.dismiss(view: view!)
    }
    
    func dismiss() {
        router?.dismiss(view: view!)
    }
    
    func getOptions() -> [String] {
        return optionList
    }
    
    func getSelectedOption() -> String {
        return selectedOption
    }
    
    func getTitle() -> String {
        return title
    }
}

extension OptionPopupPresenter: IPOptionPopupProtocol {}

extension OptionPopupPresenter: OptionPopupSegueDataProtocol {}
