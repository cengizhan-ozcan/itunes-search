//
//  QuestionPopupRouter.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/20/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

class QuestionPopupRouter: PRQuestionPopupProtocol {
    
    static func createModule(questionText: String, delegate: QuestionPopupModuleDelegate?) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "QuestionPopup", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "QuestionPopupVC") as! QuestionPopupVC
        
        var presenter: VPQuestionPopupProtocol & IPQuestionPopupProtocol & QuestionPopupSegueDataProtocol = QuestionPopupPresenter()
        let interactor: PIQuestionPopupProtocol = QuestionPopupInteractor()
        let router: PRQuestionPopupProtocol = QuestionPopupRouter()
        
        vc.presenter = presenter
        presenter.view = vc
        presenter.view = vc
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        presenter.delegate = delegate
        presenter.questionText = questionText
    
        return vc
    }
    
    func dismiss(view: PVQuestionPopupProtocol) {
        if let view = view as? UIViewController {
            view.dismiss(animated: false, completion: nil)
        }
    }
    
}
