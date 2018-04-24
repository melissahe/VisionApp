//
//  AdvertisementView.swift
//  ImageRecognitionTest
//
//  Created by Richard Crichlow on 4/21/18.
//  Copyright © 2018 Lisa J. All rights reserved.
//

import UIKit

class AdvertisementView: UIView {

    lazy var adImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "advertisementImage")
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var xButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha:0.5)
        button.titleLabel?.font =  UIFont(name: "HelveticaNeue-Medium", size: 30.0)
        return button
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
        backgroundColor = .black
        setupViews()
    }
    
    private func setupViews() {
        setupAdImageView()
        setupButton()
    }
    
    private func setupButton() {
        addSubview(xButton)
        xButton.translatesAutoresizingMaskIntoConstraints = false
        xButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        xButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.05).isActive = true
        xButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.05).isActive = true
        xButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
    }
    
    private func setupAdImageView() {
        addSubview(adImageView)
        adImageView.translatesAutoresizingMaskIntoConstraints = false
        adImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        adImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        adImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        adImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
    }

}
