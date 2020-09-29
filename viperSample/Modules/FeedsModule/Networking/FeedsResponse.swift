//
//  FeedsResponse.swift
//  viperSample
//
//  Created by Oscar Mariano Cornejo Herrera on 9/29/20.
//  Copyright © 2020 Oscar Mariano Cornejo Herrera. All rights reserved.
//

import Foundation

// MARK: - FeedsResponse
struct FeedsResponse: Codable {
    let kind: String
    let data: WelcomeData
}

// MARK: - WelcomeData
struct WelcomeData: Codable {
    let modhash: String
    let dist: Int
    let children: [Child]
    let after: String
    let before: String?
}

// MARK: - Child
struct Child: Codable {
    let data: ChildData
}

// MARK: - ChildData
struct ChildData: Codable {
    let title: String
    let thumbnail: String
    let author: String
    let numComments: Int
    let createdUTC: Int

    enum CodingKeys: String, CodingKey {
        case title
        case thumbnail
        case author
        case numComments = "num_comments"
        case createdUTC = "created_utc"
    }
}
