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
    func getFeeds(completion: @escaping (Result<FeedsResponse, Error>) -> Void) {
        let feedsEndpoint = FeedsEndpoint.feeds
        callToEndpoint(feedsEndpoint) { (result: Result<FeedsResponse, Error>) in
            switch result {
            case .success(let parsedFeedsResponse):
                completion(.success(parsedFeedsResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
