//
//  ViperModule.swift
//  viperSample
//
//  Created by Oscar Mariano Cornejo Herrera on 9/29/20.
//  Copyright © 2020 Oscar Mariano Cornejo Herrera. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Presenter
protocol Presenter {
    
    associatedtype I: NetworkInteractor
    associatedtype R: Router
    associatedtype V: ViperView
    
    var interactor: I { get set }
    var router: R { get set }
    var view: V { get set }
    
    init(view: V, interactor: I, router: R)
}

class BasePresenter<V: ViperView, I: NetworkInteractor, R: Router>: Presenter {
    
    var interactor: I
    var router: R
    unowned var view: V
    
    required init(view: V, interactor: I, router: R) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

// MARK: - NetworkInteractor
protocol NetworkInteractor {
    var client: NetworkClient { get set }
    
    init(client: NetworkClient)
    
    func callToEndpoint<T: Codable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void)
}

extension NetworkInteractor {
    func callToEndpoint<T: Codable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        client.request(endpoint: endpoint) { (result) in
            switch result {
            case .success(let data):
                print(data)
                let decoder = JSONDecoder()
                do {
                    let parsedData = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(parsedData))
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}

// MARK: - Endpoint, NetworkClient, URLSessionClient
protocol Endpoint {
    var url: String { get }
    var httpMethod: String { get }
}

protocol NetworkClient {
    func request(endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void)
}

class URLSessionClient: NetworkClient {
    func request(endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: URL(string: endpoint.url)!)
        request.httpMethod = endpoint.httpMethod
        
        URLSession(configuration: .ephemeral).dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data {
                completion(.success(data))
                return
            }
            assertionFailure("unexpected error getting data on url session client for (\(endpoint.url)")
        }).resume()
    }
}

// MARK: - Router
protocol Router {
    
}

class AppRouter: Router {
    
}

// MARK: - ViperModule
protocol ViperModule {
    
    associatedtype V: ViperView
    
    var viperView: V? { get set }
    
    func attach(view: V)
}

// MARK: - ViperView
protocol ViperView: class {
    
}

// MARK: - ViperController
class ViperController<V: ViperView & UIView>: UIViewController, ViperModule {
    
    var viperView: V?
    
    func attach(view: V) {
        self.viperView = view
    }
    
    override func loadView() {
        super.loadView()
        self.view = viperView
        self.view.backgroundColor = .white
    }
    
}
