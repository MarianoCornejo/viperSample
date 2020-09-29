//
//  FeedTableViewCell.swift
//  viperSample
//
//  Created by Oscar Mariano Cornejo Herrera on 9/29/20.
//  Copyright © 2020 Oscar Mariano Cornejo Herrera. All rights reserved.
//

import Foundation
import UIKit

class LoadingTableViewCell: UITableViewCell {
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .medium
        indicator.tintColor = .white
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    //MARK: - Initializer
    init(reuseIdentifier: String) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private
    private func setupView() {
        backgroundColor = .black
        contentView.addSubview(activityIndicatorView)
        activityIndicatorView.centerInLayout(inParentView: contentView)
    }
    
}

class FeedTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    private lazy var thumbnailImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    private var authorLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lb.textColor = .white
        return lb
    }()
    private var entryDateLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lb.textColor = .white
        return lb
    }()
    private var titleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        lb.textColor  = .white
        lb.numberOfLines = 0
        return lb
    }()
    private var numberOfCommentsLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        lb.textColor = .orange
        return lb
    }()
    private var readStatusLabel: UILabel = UILabel()
    
    //MARK: - Initializer
    init(reuseIdentifier: String) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal
    func setupCell(feedItem: Feed.FeedItem) {
        let date = DateFormatterFactory.shared.relativeDateTimeFormatter.localizedString(for: feedItem.entryDate, relativeTo: Date())
        authorLabel.text = "Posted by \(feedItem.author)"
        entryDateLabel.text = date
        titleLabel.text = feedItem.title
        numberOfCommentsLabel.text = "\(feedItem.numberOfComments) Comments"
        
        if let data = EasyCache.shared.getData(fromKey: feedItem.author) {
            thumbnailImageView.image = UIImage(data: data)
            return
        }
        
        if let url = URL(string: feedItem.thumbnailUrl) {
            DispatchQueue.global(qos: .background).async {
                if let data  = try? Data(contentsOf: url) {
                    EasyCache.shared.cache(data: data, key: feedItem.author)
                    DispatchQueue.main.async { [weak self] in
                        self?.thumbnailImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
    }
    
    //MARK: - Private
    private func setupView() {
        backgroundColor = .black
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(authorLabel)
        contentView.addSubview(entryDateLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(numberOfCommentsLabel)
        contentView.addSubview(readStatusLabel)
        
        readStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        thumbnailImageView.constraintToSize(CGSize(width: 30, height: 30))
        thumbnailImageView.pinToCorner(.topLeft(leftMargin: 0, topMargin: 10), inParentView: contentView)

        authorLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10).isActive = true
        authorLabel.expandToSides([.top(margin: 10)], inParentView: contentView)
        authorLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        authorLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        entryDateLabel.leadingAnchor.constraint(equalTo: authorLabel.trailingAnchor, constant: 10).isActive = true
        entryDateLabel.expandToSides([.top(margin: 10),.right(margin: 10)], inParentView: contentView)
        entryDateLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        entryDateLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

        titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10).isActive = true
        titleLabel.expandToSides([.right(margin: 10)], inParentView: contentView)
        
        numberOfCommentsLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10).isActive = true
        numberOfCommentsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        numberOfCommentsLabel.expandToSides([.bottom(margin: 0), .right(margin: 10)], inParentView: contentView)
    }
}
