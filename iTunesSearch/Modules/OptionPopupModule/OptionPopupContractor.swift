//
//  OptionPopupContractor.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/21/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

// MARK: Segue Data
protocol OptionPopupSegueDataProtocol {
    var optionList: [String]! { get set }
    var selectedOption: String! { get set }
    var title: String! { get set }
}

// MARK: View Input (View -> Presenter)
protocol VPOptionPopupProtocol {
    var view: PVOptionPopupProtocol? { get set }
    var interactor: PIOptionPopupProtocol? { get set }
    var router: PROptionPopupProtocol? { get set }
    var delegate: OptionPopupModuleDelegate? { get set }
    
    func onSelectOption(for option: String)
    func onSelection()
    func dismiss()
    func getOptions() -> [String]
    func getSelectedOption() -> String
    func getTitle() -> String
}

// MARK: View Output (Presenter -> View)
protocol PVOptionPopupProtocol: class {
    
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PIOptionPopupProtocol: class {
    var presenter: IPOptionPopupProtocol? { get set }
    
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol IPOptionPopupProtocol: class {
    
}

// MARK: Router Input (Presenter -> Router)
protocol PROptionPopupProtocol {
    static func createModule(title: String, optionList: [String],
                             selectedOption: String, delegate: OptionPopupModuleDelegate?) -> UIViewController
    func dismiss(view: PVOptionPopupProtocol)
}

protocol OptionPopupModuleDelegate {
    func onSelected(option: String)
}

