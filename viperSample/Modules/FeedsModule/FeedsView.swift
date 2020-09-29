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
    var feeds: [Feed] { get set }
    
    func setFeeds(_ feeds: [Feed])
    func showError(_ error: Error)
}

class FeedsView: UIView, FeedsViperView {
    
    // MARK: - Properties
    private lazy var presenter: FeedsPresenter<FeedsView, FeedsInteractor, AppRouter> = FeedsPresenter(view: self, interactor: FeedsInteractor(client: URLSessionClient()), router: AppRouter())
    private var tableView: UITableView = UITableView(frame: .zero)
    
    struct TableViewCells {
        static let feed = "FeedTableViewCell"
    }
    
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
        tableView.expandTofitLayoutFromView(self)
        tableView.dataSource = self
    }
    
    // MARK: - FeedsViperView
    var feeds: [Feed] = []
    
    func setFeeds(_ feeds: [Feed]) {
        self.feeds = feeds
        self.tableView.reloadData()
    }
    
    func showError(_ error: Error) {
        print(error)
    }
    
}

// MARK: - UITableViewDataSource
extension FeedsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: FeedsView.TableViewCells.feed) as? FeedTableViewCell
        if cell == nil {
            cell = FeedTableViewCell(reuseIdentifier: FeedsView.TableViewCells.feed)
        }
        cell?.setupCell(feed: feeds[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
}
