//
//  TargetLanguageView.swift
//  ImageRecognitionTest
//
//  Created by Richard Crichlow on 4/21/18.
//  Copyright © 2018 Lisa J. All rights reserved.
//

import UIKit

class TargetLanguageView: DismissViewTemplate {

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
        containerView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
        
    }

}
