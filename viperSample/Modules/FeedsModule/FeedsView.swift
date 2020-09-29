//
//  FeedsView.swift
//  viperSample
//
//  Created by Oscar Mariano Cornejo Herrera on 9/29/20.
//  Copyright © 2020 Oscar Mariano Cornejo Herrera. All rights reserved.
//

import Foundation
import UIKit

class FeedsView: UIView, ViperView {
    
    private lazy var presenter: FeedsPresenter = {
        let client = URLSessionClient()
        return FeedsPresenter(view: FeedsView(), interactor: FeedsInteractor(client: client), router: AppRouter())
    }()
    
    
    
}
