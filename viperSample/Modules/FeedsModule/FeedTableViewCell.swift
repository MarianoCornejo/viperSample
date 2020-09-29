//
//  FeedTableViewCell.swift
//  viperSample
//
//  Created by Oscar Mariano Cornejo Herrera on 9/29/20.
//  Copyright © 2020 Oscar Mariano Cornejo Herrera. All rights reserved.
//

import Foundation
import UIKit

class FeedTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    private lazy var thumbnailImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .black
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    private var authorLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lb.textColor = .gray
        return lb
    }()
    private var entryDateLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lb.textColor = .gray
        return lb
    }()
    private var titleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        lb.numberOfLines = 0
        return lb
    }()
    private var numberOfCommentsLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        lb.textColor = .gray
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
    func setupCell(feed: Feed) {
        let date = DateFormatterFactory.shared.relativeDateTimeFormatter.localizedString(for: feed.entryDate, relativeTo: Date())
        authorLabel.text = "Posted by \(feed.author)"
        entryDateLabel.text = date
        titleLabel.text = feed.title
        numberOfCommentsLabel.text = "\(feed.numberOfComments) Comments"
    }
    
    //MARK: - Private
    private func setupView() {
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
