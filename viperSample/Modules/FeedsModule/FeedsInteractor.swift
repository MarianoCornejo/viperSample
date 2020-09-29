//
//  FeedsInteractor.swift
//  viperSample
//
//  Created by Oscar Mariano Cornejo Herrera on 9/29/20.
//  Copyright © 2020 Oscar Mariano Cornejo Herrera. All rights reserved.
//

import Foundation

class FeedsInteractor: NetworkInteractor {
    
    var client: NetworkClient
    
    required init(client: NetworkClient) {
        self.client = client
    }
    
}
