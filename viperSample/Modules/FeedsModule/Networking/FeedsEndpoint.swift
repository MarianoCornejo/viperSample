//
//  FeedsEndpoint.swift
//  viperSample
//
//  Created by Oscar Mariano Cornejo Herrera on 9/29/20.
//  Copyright © 2020 Oscar Mariano Cornejo Herrera. All rights reserved.
//

import Foundation

enum FeedsEndpoint: Endpoint {
    
    var url: String {
        return "https://www.reddit.com/r/all/top/.json?t=all&limit=10"
    }
    
    var httpMethod: String {
        return "GET"
    }
    
    case feeds
    
}
