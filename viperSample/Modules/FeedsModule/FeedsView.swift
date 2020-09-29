//
//  FeedsView.swift
//  viperSample
//
//  Created by Oscar Mariano Cornejo Herrera on 9/29/20.
//  Copyright © 2020 Oscar Mariano Cornejo Herrera. All rights reserved.
//

import Foundation
import UIKit

protocol FeedsViperView: ViperView {
    var feeds: FeedsResponse? { get set }
    
    func setFeeds(_ feeds: FeedsResponse)
    func showError(_ error: Error)
}

class FeedsView: UIView, FeedsViperView {
    
    // MARK: - Properties
    private lazy var presenter: FeedsPresenter<FeedsView, FeedsInteractor, AppRouter> = FeedsPresenter(view: self, interactor: FeedsInteractor(client: URLSessionClient()), router: AppRouter())
    private var tableView: UITableView = UITableView(frame: .zero)
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        setupTableView()
        presenter.getFeeds()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.dataSource = self
    }
    
    // MARK: - FeedsViperView
    var feeds: FeedsResponse?
    
    func setFeeds(_ feeds: FeedsResponse) {
        self.feeds = feeds
        print(feeds)
    }
    
    func showError(_ error: Error) {
        print(error)
    }
    
}

extension FeedsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        return cell ?? UITableViewCell()
    }
    
}
