//
//  EasyCache.swift
//  viperSample
//
//  Created by Oscar Mariano Cornejo Herrera on 9/29/20.
//  Copyright © 2020 Oscar Mariano Cornejo Herrera. All rights reserved.
//

import Foundation

class EasyCache {
    static let shared = EasyCache()
    
    var cachedData: [String: Data] = [:]
    
    func cache(data: Data, key: String) {
        cachedData[key] = data
    }
    
    func getData(fromKey key: String) -> Data? {
        return cachedData[key]
    }
}
