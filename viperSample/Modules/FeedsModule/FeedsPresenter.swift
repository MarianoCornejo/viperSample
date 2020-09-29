//
//  FeedsPresenter.swift
//  viperSample
//
//  Created by Oscar Mariano Cornejo Herrera on 9/29/20.
//  Copyright © 2020 Oscar Mariano Cornejo Herrera. All rights reserved.
//

import Foundation

class FeedsPresenter<V: FeedsViperView, I: FeedsInteractor, R: AppRouter>: BasePresenter<V, I, R> {
    
    func getFeeds() {
        view.showLoadingFeedback(show: true)
        interactor.getFeeds { (result) in
            switch result {
            case .success(let response):
                self.view.showLoadingFeedback(show: false)
                self.view.setFeeds(response)
            case .failure(let error):
                self.view.showLoadingFeedback(show: false)
                self.view.showError(error)
            }
        }
    }
    
}
