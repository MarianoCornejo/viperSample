//
//  FeedsInteractor.swift
//  viperSample
//
//  Created by Oscar Mariano Cornejo Herrera on 9/29/20.
//  Copyright © 2020 Oscar Mariano Cornejo Herrera. All rights reserved.
//

import Foundation

class FeedsInteractor: NetworkInteractor {
    
    // MARK: - Properties
    var client: NetworkClient
    
    // MARK: - Initializer
    required init(client: NetworkClient) {
        self.client = client
    }
    
    // MARK: - Properties
    func getFeeds(completion: @escaping (Result<[Feed], Error>) -> Void) {
        let feedsEndpoint = FeedsEndpoint.feeds
        callToEndpoint(feedsEndpoint) { (result: Result<FeedsResponse, Error>) in
            switch result {
            case .success(let parsedFeedsResponse):
                let feeds = parsedFeedsResponse.data.children.map({ Feed(childData: $0.data) })
                completion(.success(feeds))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
