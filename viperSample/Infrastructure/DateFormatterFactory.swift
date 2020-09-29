//
//  DateFormatterFactory.swift
//  viperSample
//
//  Created by Oscar Mariano Cornejo Herrera on 9/29/20.
//  Copyright © 2020 Oscar Mariano Cornejo Herrera. All rights reserved.
//

import Foundation

class DateFormatterFactory {
    
    static let shared = DateFormatterFactory()
    
    private init() {}
    
    lazy var relativeDateTimeFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        return formatter
    }()
}
