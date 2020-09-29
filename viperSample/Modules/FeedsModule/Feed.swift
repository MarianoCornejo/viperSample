//
//  Feed.swift
//  viperSample
//
//  Created by Oscar Mariano Cornejo Herrera on 9/29/20.
//  Copyright © 2020 Oscar Mariano Cornejo Herrera. All rights reserved.
//

import Foundation

struct Feed {
    var before: String = ""
    var after: String = ""
    var feeds: [FeedItem] = []
    
    struct FeedItem {
        var author: String
        var title: String
        var thumbnailUrl: String
        var entryDate: Date
        var numberOfComments: Int
        var unreadStatus: String
    }
}

extension Feed {
    init(response: FeedsResponse) {
        before = response.data.before ?? ""
        after = response.data.after
        feeds = response.data.children.map({ FeedItem(childData: $0.data) })
    }
    
}

extension Feed.FeedItem {
    init(childData: ChildData) {
        author = childData.author
        title = childData.title
        thumbnailUrl = childData.thumbnail
        entryDate = Date(timeIntervalSince1970: TimeInterval(childData.createdUTC))
        numberOfComments = childData.numComments
        unreadStatus = ""
    }
}
