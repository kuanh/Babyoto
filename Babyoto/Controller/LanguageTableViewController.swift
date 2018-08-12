//
//  LanguageTableViewController.swift
//  BabyOto
//
//  Created by Developer on 7/23/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class LanguageTableViewController: UITableViewController {
    
    var languages: [String] = []
    var isHighlight: Bool = true
    @IBOutlet weak var clearView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for language in String.Language.values {
            languages.append(language.rawValue)
        }
        UserDefaults.standard.set("Base", forKey: "locate")
        
        self.navigationItem.title = StringLanguage.p3_title.localized
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = #colorLiteral(red: 0.2196078431, green: 0.3411764706, blue: 0.5607843137, alpha: 1).as1ptImage()
        
        tableView.separatorStyle = .none
        
        GoogleAdMob.sharedInstance.initializeBannerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return languages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath) as! LanguageTableViewCell
        
        if let locale = UserDefaults.standard.object(forKey: "locate") as? String {
            if locale == "Base" && languages[indexPath.row] == String.Language.english.rawValue {
                cell.checkmark.highlightedImage = UIImage(named: "ico_check")
                cell.checkmark.isHighlighted = isHighlight
                isHighlight = false
            }
        }
        
        cell.locale.text = languages[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! LanguageTableViewCell
        if isHighlight == false {
            cell.checkmark.highlightedImage = nil
            cell.checkmark.isHighlighted = isHighlight
            tableView.reloadData()
        }
        
        cell.checkmark.image = UIImage(named: "ico_check")
        
        let backgroundImage: UIImageView = UIImageView(frame: cell.bounds)
        let image: UIImage = UIImage(named: "btn_default")!
        backgroundImage.image = image
        cell.backgroundView = backgroundImage
        switch languages[indexPath.row] {
        case String.Language.english.rawValue:
            UserDefaults.standard.set("Base", forKey: "locate")
        case String.Language.chinese.rawValue:
            UserDefaults.standard.set("zh-Hans", forKey: "locate")
        case String.Language.thailand.rawValue:
            UserDefaults.standard.set("th", forKey: "locate")
        case String.Language.japanese.rawValue:
            UserDefaults.standard.set("ja", forKey: "locate")
        default:
            UserDefaults.standard.set("vi", forKey: "locate")
        }
        
        self.perform(#selector(performAction), with: nil, afterDelay: 1.5)
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! LanguageTableViewCell
        cell.checkmark.image = nil
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let addSeparatorThickness: CGFloat = 1
        let addSeparator: UIView = UIView(frame: CGRect(x: 0, y: cell.frame.size.height - addSeparatorThickness, width: cell.frame.size.width, height: addSeparatorThickness))
        addSeparator.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.3411764706, blue: 0.5607843137, alpha: 1)
        cell.addSubview(addSeparator)
    }
    
    @objc func performAction() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.present(homeViewController, animated: true, completion: nil)
    }

}
