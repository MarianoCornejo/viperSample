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
        switch self {
        case .feeds(let after):
            let queryString = after.isEmpty ? "" : "&after=\(after)"
            return "https://www.reddit.com/r/all/top/.json?t=all&limit=10\(queryString)"
        }
    }
    
    var httpMethod: String {
        return "GET"
    }
    
    case feeds(after: String)
    
}
