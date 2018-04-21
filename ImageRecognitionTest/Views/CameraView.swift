//
//  View.swift
//  ImageRecognitionTest
//
//  Created by Lisa J on 4/20/18.
//  Copyright © 2018 Lisa J. All rights reserved.
//

import UIKit

class CameraView: UIView {
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Translate", for: .normal)
        button.backgroundColor = .black
        return button
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label"
        label.font = label.font.withSize(30)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var baseLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle("B\na\ns\ne\n \nL\na\nn\ng\nu\na\ng\ne", for: .normal)
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha:0.5)
        button.titleLabel?.font =  UIFont(name: "HelveticaNeue-Medium", size: 17.0)
        button.titleLabel?.lineBreakMode = .byCharWrapping
        
        return button
    }()
    
    lazy var targetLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle("T\na\nr\ng\ne\nt\n \nL\na\nn\ng\nu\na\ng\ne", for: .normal)
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha:0.5)
        button.titleLabel?.font =  UIFont(name: "HelveticaNeue-Medium", size: 17.0)
        button.titleLabel?.lineBreakMode = .byCharWrapping
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
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        baseLanguageButton.roundCorners([.bottomRight, .topRight], radius: 20)
        targetLanguageButton.roundCorners([.topLeft, .bottomLeft], radius: 20)
    }
    
    private func setupViews() {
        setupLabel()
        setupButton()
        setupBaseLanguageButton()
        setupTargetLangaugeButton()
    }
    
    private func setupLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        label.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1).isActive = true
        label.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.20).isActive = true
    }
    
    private func setupButton() {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1).isActive = true
        button.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
    }
    
    private func setupBaseLanguageButton() {
        addSubview(baseLanguageButton)
        baseLanguageButton.translatesAutoresizingMaskIntoConstraints = false
        baseLanguageButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        baseLanguageButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.1).isActive = true
        baseLanguageButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true
        baseLanguageButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        
    }
    
    private func setupTargetLangaugeButton() {
        addSubview(targetLanguageButton)
        targetLanguageButton.translatesAutoresizingMaskIntoConstraints = false
        targetLanguageButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        targetLanguageButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.1).isActive = true
        targetLanguageButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true
        targetLanguageButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
}
extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}
