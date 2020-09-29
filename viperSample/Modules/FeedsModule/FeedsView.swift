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
    func showLoadingFeedback(show: Bool)
}

class FeedsView: UIView, FeedsViperView {
    
    // MARK: - Properties
    private lazy var presenter: FeedsPresenter<FeedsView, FeedsInteractor, AppRouter> = FeedsPresenter(view: self, interactor: FeedsInteractor(client: URLSessionClient()), router: AppRouter())
    private var tableView: UITableView = UITableView(frame: .zero)
    private var refreshControl: UIRefreshControl = UIRefreshControl()
    private var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView(frame: .zero)
    
    struct TableViewCells {
        static let feed = "FeedTableViewCell"
    }
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        setupActivityIndicator()
        setupTableView()
        setupRefreshControll()
        presenter.getFeeds()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    private func setupActivityIndicator() {
        addSubview(activityIndicatorView)
        activityIndicatorView.tintColor = .black
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.style = .large
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.constraintToSize(CGSize(width: 30, height: 30))
        activityIndicatorView.centerInLayout(inParentView: self)
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        tableView.expandTofitLayoutFromView(self)
        tableView.dataSource = self
        tableView.isHidden = true
    }
    
    private func setupRefreshControll() {
        refreshControl.addTarget(self, action: #selector(refreshFeeds), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshFeeds() {
        presenter.getFeeds()
    }
    
    // MARK: - FeedsViperView
    var feeds: [Feed] = []
    
    func setFeeds(_ feeds: [Feed]) {
        self.feeds = feeds
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    func showError(_ error: Error) {
        print(error)
    }
    
    func showLoadingFeedback(show: Bool) {
        if !show {
            activityIndicatorView.stopAnimating()
            tableView.isHidden = false
        } else {
            activityIndicatorView.startAnimating()
        }
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
