//
//  BaseLanguageView.swift
//  ImageRecognitionTest
//
//  Created by Richard Crichlow on 4/21/18.
//  Copyright © 2018 Lisa J. All rights reserved.
//

import UIKit

class BaseLanguageView: DismissViewTemplate {

    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.text = "Choose Your Language"
        let font = UIFont(name: "HelveticaNeue-Medium", size: 25)!
        label.font = font
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(LanguageTableViewCell.self, forCellReuseIdentifier: "Language Cell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        containerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.1).isActive = true
        
        containerView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
        
    }

}
