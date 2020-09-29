//
//  QuestionPopupPresenter.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/20/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit

class QuestionPopupPresenter: VPQuestionPopupProtocol {
    
    weak var view: PVQuestionPopupProtocol?
    var interactor: PIQuestionPopupProtocol?
    var router: PRQuestionPopupProtocol?
    var delegate: QuestionPopupModuleDelegate?
    
    var questionText: String!
    
    func onAnswer(_ isConfirmed: Bool) {
        delegate?.onAnswer(isConfirmed: isConfirmed)
        router?.dismiss(view: view!)
    }
    
    func dismiss() {
        router?.dismiss(view: view!)
    }
    
    func getQuestion() -> String {
        return questionText
    }
    
}

extension QuestionPopupPresenter: IPQuestionPopupProtocol {}


extension QuestionPopupPresenter: QuestionPopupSegueDataProtocol {}
