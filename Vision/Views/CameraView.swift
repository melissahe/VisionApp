//
//  View.swift
//  ImageRecognitionTest
//
//  Created by Lisa J on 4/20/18.
//  Copyright © 2018 Lisa J. All rights reserved.
//

import UIKit

class CameraView: UIView {
    
    lazy var activityImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "activityIndicator"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Translate", for: .normal)
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha:0.8)
        return button
    }()
    
    lazy var untranslatedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = label.font.withSize(30)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var translatedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Translated Text Here"
        label.font = label.font.withSize(30)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var baseLanguageButton: UIButton = {
        let button = UIButton()
        var title: String?
        if let targetLanguage = UserDefaultsHelper.manager.getTargetLanguage() {
            let stringArray = Array(targetLanguage).map{String($0)}
            let stringSeparatedByBreaks = stringArray.joined(separator: "\n")
            title = stringSeparatedByBreaks
        } else {
            title = "N\no\n \nL\na\nn\ng\nu\na\ng\ne\n \nS\ne\nt"
        }
        button.setTitle(title, for: .normal)
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
    
    public func spinActivityImageView() {
        activityImageView.isHidden = false
        let spinAnimation = CABasicAnimation(keyPath: "transform.rotation")
        spinAnimation.fromValue = 0
        spinAnimation.toValue = 2 * Float.pi
        spinAnimation.duration = 0.7
        spinAnimation.repeatCount = Float.infinity
        spinAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        activityImageView.layer.add(spinAnimation, forKey: nil)
    }
    
    public func stopActivityImageView() {
        activityImageView.isHidden = true
        activityImageView.layer.removeAllAnimations()
    }
    
    private func commonInit() {
        setupViews()
        baseLanguageButton.isUserInteractionEnabled = false
        activityImageView.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        baseLanguageButton.roundCorners([.bottomRight, .topRight], radius: 20)
        targetLanguageButton.roundCorners([.topLeft, .bottomLeft], radius: 20)
    }
    
    private func setupViews() {
        setupButton()
        setupTranslatedLabel()
        setupActivityImageView()
        setupUntranslatedLabel()
        setupBaseLanguageButton()
        setupTargetLanguageButton()
    }
    
    private func setupButton() {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        button.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.10).isActive = true
    }
    
    private func setupTranslatedLabel() {
        addSubview(translatedLabel)
        translatedLabel.translatesAutoresizingMaskIntoConstraints = false
        translatedLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        translatedLabel.bottomAnchor.constraint(equalTo: button.topAnchor).isActive = true
        translatedLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1).isActive = true
        translatedLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.20).isActive = true
    }
    
    private func setupActivityImageView() {
        addSubview(activityImageView)
        
        activityImageView.translatesAutoresizingMaskIntoConstraints = false
        activityImageView.bottomAnchor.constraint(equalTo: translatedLabel.topAnchor).isActive = true
        activityImageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        activityImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.05).isActive = true
    }
    
    private func setupUntranslatedLabel() {
        addSubview(untranslatedLabel)
        
        untranslatedLabel.translatesAutoresizingMaskIntoConstraints = false
        untranslatedLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        untranslatedLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        untranslatedLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.85).isActive = true
        untranslatedLabel.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.30).isActive = true
    }
    
    private func setupBaseLanguageButton() {
        addSubview(baseLanguageButton)
        baseLanguageButton.translatesAutoresizingMaskIntoConstraints = false
        baseLanguageButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        baseLanguageButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.1).isActive = true
        baseLanguageButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true
        baseLanguageButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        
    }
    
    private func setupTargetLanguageButton() {
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
