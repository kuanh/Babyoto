//
//  ViewController.swift
//  BabyOto
//
//  Created by Developer on 7/23/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.perform(#selector(performAction), with: nil, afterDelay: 1)
    }
    
    @objc func performAction() {
        let isFirst: Bool = UserDefaults.standard.bool(forKey: "isFirst")
        if isFirst == false {
            UserDefaults.standard.set(true, forKey: "isFirst")
            let languageViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LanguageViewController") as? LanguageTableViewController
            let navigationController = UINavigationController(rootViewController: languageViewController!)
            navigationController.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.1058823529, blue: 0.3176470588, alpha: 1)
            navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
            navigationController.navigationBar.isTranslucent = false
            self.present(navigationController, animated: true, completion: nil)
        } else {
            let homeViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController

            self.present(homeViewController!, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

