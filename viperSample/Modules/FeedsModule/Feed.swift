//
//  Feed.swift
//  viperSample
//
//  Created by Oscar Mariano Cornejo Herrera on 9/29/20.
//  Copyright © 2020 Oscar Mariano Cornejo Herrera. All rights reserved.
//

import Foundation

struct Feed {
    var author: String
    var title: String
    var thumbnailUrl: String
    var entryDate: Date
    var numberOfComments: Int
    var unreadStatus: String
}

extension Feed {
    init(childData: ChildData) {
        author = childData.author
        title = childData.title
        thumbnailUrl = childData.thumbnail
        entryDate = Date(timeIntervalSince1970: TimeInterval(childData.createdUTC))
        numberOfComments = childData.numComments
        unreadStatus = ""
    }
}
