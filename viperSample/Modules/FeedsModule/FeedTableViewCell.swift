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
    private var thumbnailImageView: UIImageView = UIImageView(frame: .zero)
    private var authorLabel: UILabel = UILabel(frame: .zero)
    private var entryDateLabel: UILabel = UILabel(frame: .zero)
    private var titleLabel: UILabel = UILabel(frame: .zero)
    private var numberOfCommentsLabel: UILabel = UILabel(frame: .zero)
    private var readStatusLabel: UILabel = UILabel(frame: .zero)
    
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
        authorLabel.text = feed.author
    }
    
    //MARK: - Private
    private func setupView() {
        addSubview(thumbnailImageView)
        addSubview(authorLabel)
        addSubview(entryDateLabel)
        addSubview(titleLabel)
        addSubview(numberOfCommentsLabel)
        addSubview(readStatusLabel)
        
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        entryDateLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfCommentsLabel.translatesAutoresizingMaskIntoConstraints = false
        readStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        thumbnailImageView.backgroundColor = .black
        thumbnailImageView.constraintToSize(CGSize(width: 30, height: 30))
        thumbnailImageView.pinToCorner(.topLeft(leftMargin: 10, topMargin: 10), inParentView: self)
        
        authorLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10).isActive = true
        authorLabel.expandToSides([.top(margin: 10), .right(margin: 10)], inParentView: self)
        authorLabel.text = "adfas"
    }
}
