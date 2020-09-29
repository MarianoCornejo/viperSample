//
//  FeedsView.swift
//  viperSample
//
//  Created by Oscar Mariano Cornejo Herrera on 9/29/20.
//  Copyright © 2020 Oscar Mariano Cornejo Herrera. All rights reserved.
//

import Foundation
import UIKit

protocol FeedsViperView: ViperView {
    var feeds: FeedsResponse? { get set }
    
    func setFeeds(_ feeds: FeedsResponse)
    func showError(_ error: Error)
}

class FeedsView: UIView, FeedsViperView {
    
    // MARK: - Properties
    var feeds: FeedsResponse?
    
    private lazy var presenter: FeedsPresenter<FeedsView, FeedsInteractor, AppRouter> = FeedsPresenter(view: self, interactor: FeedsInteractor(client: URLSessionClient()), router: AppRouter())
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        presenter.getFeeds()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal
    func setFeeds(_ feeds: FeedsResponse) {
        self.feeds = feeds
        print(feeds)
    }
    
    func showError(_ error: Error) {
        print(error)
    }
    
}
