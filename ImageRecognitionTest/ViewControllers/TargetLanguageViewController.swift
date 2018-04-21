//
//  TargetLanguageViewController.swift
//  ImageRecognitionTest
//
//  Created by Richard Crichlow on 4/21/18.
//  Copyright © 2018 Lisa J. All rights reserved.
//

import UIKit

class TargetLanguageViewController: UIViewController {
    
    let targetLanguageView = TargetLanguageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(targetLanguageView)
        targetLanguageView.dismissView.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    @objc func dismissView() {
        
        // Dismiss Animation
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromLeft
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        //Dismiss action
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
