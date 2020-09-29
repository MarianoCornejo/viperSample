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
        interactor.getFeeds(after: "") { (result) in
            switch result {
            case .success(let feed):
                self.view.showLoadingFeedback(show: false)
                self.view.setFeed(feed)
            case .failure(let error):
                self.view.showLoadingFeedback(show: false)
                self.view.showError(error)
            }
        }
    }
    
    func getNextFeeds(feed: Feed) {
        interactor.getFeeds(after: feed.after) { (result) in
            switch result {
            case .success(let feed):
                self.view.setNextPageFeed(feed)
            case .failure(let error):
                self.view.showError(error)
            }
        }
    }
    
}
