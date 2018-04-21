//
//  BaseLanguageViewController.swift
//  ImageRecognitionTest
//
//  Created by Richard Crichlow on 4/21/18.
//  Copyright © 2018 Lisa J. All rights reserved.
//

import UIKit

class BaseLanguageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let baseLanguageView = BaseLanguageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(baseLanguageView)
        baseLanguageView.dismissView.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        baseLanguageView.tableView.dataSource = self
        baseLanguageView.tableView.delegate = self
    }
    
    @objc func dismissView() {
        
        // Dismiss Animation
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        //Dismiss action
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Tableview DataSource and Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Languages.allLanguages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let testData = Languages.allLanguages[indexPath.row]
        let cell = baseLanguageView.tableView.dequeueReusableCell(withIdentifier: "Language Cell", for: indexPath) as! LanguageTableViewCell
        cell.placeLabel.text = testData
        return cell
    }
    
    
}
