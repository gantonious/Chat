//
//  ConversationViewCell.swift
//  Chat
//
//  Created by George Antonious on 2018-06-01.
//  Copyright © 2018 George Antonious. All rights reserved.
//

import UIKit

class ConversationViewCell: UITableViewCell {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let lastMessageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    private func buildViews() {
        let safeMargins = contentView.safeAreaLayoutGuide
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(lastMessageLabel)
        
        titleLabel
            .anchorTop(to: safeMargins.topAnchor, withConstant: 16)
            .fillWidth(inside: safeMargins, withConstant: 16)
            .done()
        
        lastMessageLabel
            .anchorTop(to: titleLabel.bottomAnchor, withConstant: 8)
            .anchorBottom(to: safeMargins.bottomAnchor, withConstant: -16)
            .fillWidth(inside: safeMargins, withConstant: 16)
            .done()
    }
    
    func render(conversation: Conversation) {
        titleLabel.text = conversation.name
        lastMessageLabel.text = conversation.latestMessage
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
