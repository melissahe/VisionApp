//
//  PlaceTableViewCell.swift
//  ImageRecognitionTest
//
//  Created by Richard Crichlow on 4/21/18.
//  Copyright © 2018 Lisa J. All rights reserved.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {
    
    lazy var languageLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Test"
        let font = UIFont(name: "HelveticaNeue-Medium", size: 40)!
        lb.font = font
        lb.textAlignment = .center
        lb.numberOfLines = 0
        return lb
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: "Language Cell")
        setupAndConstrainObjects()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAndConstrainObjects()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAndConstrainObjects()
    }
    
    private func setupAndConstrainObjects(){
        addSubview(languageLabel)
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        languageLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        languageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        languageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        languageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}
