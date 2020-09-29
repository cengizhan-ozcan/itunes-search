//
//  OptionPopupRouter.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/21/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

class OptionPopupRouter: PROptionPopupProtocol {
    
    static func createModule(title: String, optionList: [String],
                             selectedOption: String, delegate: OptionPopupModuleDelegate?) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "OptionPopup", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "OptionPopupVC") as! OptionPopupVC
        
        var presenter: VPOptionPopupProtocol & IPOptionPopupProtocol & OptionPopupSegueDataProtocol = OptionPopupPresenter()
        let interactor: PIOptionPopupProtocol = OptionPopupInteractor()
        let router: PROptionPopupProtocol = OptionPopupRouter()
        
        vc.presenter = presenter
        presenter.view = vc
        presenter.view = vc
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        presenter.delegate = delegate
        presenter.optionList = optionList
        presenter.selectedOption = selectedOption
        presenter.title = title
    
        return vc
    }
    
    func dismiss(view: PVOptionPopupProtocol) {
        if let view = view as? UIViewController {
            view.dismiss(animated: false, completion: nil)
        }
    }
    
}
