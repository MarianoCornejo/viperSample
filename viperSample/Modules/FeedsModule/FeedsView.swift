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
    var feed: Feed? { get set }
    
    func setFeed(_ feed: Feed)
    func showError(_ error: Error)
    func showLoadingFeedback(show: Bool)
    func setNextPageFeed(_ feed: Feed)
}

class FeedsView: UIView, FeedsViperView {
    
    // MARK: - Properties
    private lazy var presenter: FeedsPresenter<FeedsView, FeedsInteractor, AppRouter> = FeedsPresenter(view: self, interactor: FeedsInteractor(client: URLSessionClient()), router: AppRouter())
    private var tableView: UITableView = UITableView(frame: .zero)
    private var refreshControl: UIRefreshControl = UIRefreshControl()
    private var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView(frame: .zero)
    
    struct TableViewCells {
        static let feed = "FeedTableViewCell"
        static let loading = "LoadingTableViewCell"
    }
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        backgroundColor = .black
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
        activityIndicatorView.tintColor = .white
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
        tableView.backgroundColor = .black
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
    }
    
    private func setupRefreshControll() {
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refreshFeeds), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshFeeds() {
        presenter.getFeeds()
    }
    
    // MARK: - FeedsViperView
    var feed: Feed?
    
    func setFeed(_ feed: Feed) {
        self.feed = feed
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
    
    func setNextPageFeed(_ feed: Feed) {
        isLoadingMoreData = false
        self.feed?.after = feed.after
        self.feed?.feeds.append(contentsOf: feed.feeds)
        tableView.reloadData()
    }
    var isLoadingMoreData = false
}

// MARK: - UITableViewDataSource
extension FeedsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = feed?.feeds.count {
            if isLoadingMoreData {
                return count + 1
            }
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let count = feed?.feeds.count else {
            return UITableViewCell()
        }
        
        if indexPath.row == count && isLoadingMoreData {
            var cell = tableView.dequeueReusableCell(withIdentifier: FeedsView.TableViewCells.loading) as? LoadingTableViewCell
            if cell == nil {
                cell = LoadingTableViewCell(reuseIdentifier: FeedsView.TableViewCells.loading)
            }
            return cell ?? UITableViewCell()
        }
        
        var cell = tableView.dequeueReusableCell(withIdentifier: FeedsView.TableViewCells.feed) as? FeedTableViewCell
        if cell == nil {
            cell = FeedTableViewCell(reuseIdentifier: FeedsView.TableViewCells.feed)
        }
        if let feedItem = feed?.feeds[indexPath.row] {
            cell?.setupCell(feedItem: feedItem)
        }
        return cell ?? UITableViewCell()
    }
    
}

extension FeedsView: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let endOffset = scrollView.contentOffset.y + scrollView.bounds.size.height
        if endOffset >= scrollView.contentSize.height {
            if let count = feed?.feeds.count, isLoadingMoreData == false {
                isLoadingMoreData = true
                tableView.insertRows(at: [IndexPath(item: count, section: 0)], with: .fade)
                if let feed = feed {
                    presenter.getNextFeeds(feed: feed)
                }
            }
        }
    }
}
