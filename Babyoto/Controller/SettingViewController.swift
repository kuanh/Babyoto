//
//  SettingViewController.swift
//  BabyOto
//
//  Created by Developer on 8/3/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    var listLanguages: [String] = []
    var listOther: [String] = [StringLanguage.p4_share_friend.localized, StringLanguage.p4_babyrepo.localized]
    var isHighlight: Bool = true
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var settingNavigationBar: UINavigationBar!
    @IBOutlet weak var displayNavigationBar: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        for language in String.Language.values {
            listLanguages.append(language.rawValue)
        }
        settingNavigationBar.topItem?.title = StringLanguage.p4_title.localized
        displayNavigationBar.addSubview(settingNavigationBar)
        displayNavigationBar.addBorders(edges: [.bottom], color: #colorLiteral(red: 0.2196078431, green: 0.3411764706, blue: 0.5607843137, alpha: 1), width: 1)
        versionLabel.text = StringLanguage.p4_version.localized + " 1.0.1"
        
        tableView.separatorStyle = .none
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        GoogleAdMob.sharedInstance.initializeBannerView()
    }

    @IBAction func backToHomeViewcontroller(_ sender: UIBarButtonItem) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.present(homeViewController, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return listLanguages.count
        } else {
            return listOther.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath) as! SettingLanguageTableViewCell
            if let locale = UserDefaults.standard.object(forKey: "locate") as? String {
                if locale == "ja" && listLanguages[indexPath.row] == String.Language.japanese.rawValue
                    || locale == "Base" && listLanguages[indexPath.row] == String.Language.english.rawValue
                    || locale == "zh-Hans" && listLanguages[indexPath.row] == String.Language.chinese.rawValue
                    || locale == "th" && listLanguages[indexPath.row] == String.Language.thailand.rawValue
                    || locale == "vi" && listLanguages[indexPath.row] == String.Language.vietnamese.rawValue  {
                    cell.checkMark.highlightedImage = UIImage(named: "ico_check")
                    cell.checkMark.isHighlighted = isHighlight
                    isHighlight = false
                }
            }
            cell.displayLanguage.text = listLanguages[indexPath.row]
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "otherCell", for: indexPath) as! SettingOtherTableViewCell
            cell.nameOther.text = listOther[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let cell = tableView.cellForRow(at: indexPath) as! SettingLanguageTableViewCell
            if isHighlight == false {
                cell.checkMark.highlightedImage = nil
                cell.checkMark.isHighlighted = isHighlight
                tableView.reloadData()
            }
            cell.checkMark.image = UIImage(named: "ico_check")
            switch listLanguages[indexPath.row] {
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
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.present(homeViewController, animated: true, completion: nil)
        } else {
            if indexPath.row == 0 {
                let text = "FaceBook"
                if let image = UIImage(named: "ico_fb"){
                    let activityViewController = UIActivityViewController(activityItems: [image, text], applicationActivities: nil)
                    
                    self.present(activityViewController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let cell = tableView.cellForRow(at: indexPath) as! SettingLanguageTableViewCell
            cell.checkMark.image = nil
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let addSeparatorThickness: CGFloat = 1
        let addSeparator: UIView = UIView(frame: CGRect(x: 0, y: cell.frame.size.height - addSeparatorThickness, width: cell.frame.size.width, height: addSeparatorThickness))
        addSeparator.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.3411764706, blue: 0.5607843137, alpha: 1)
        cell.addSubview(addSeparator)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let tableViewHeaderFooterView = view as? UITableViewHeaderFooterView {
            tableViewHeaderFooterView.backgroundView?.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.1960784314, blue: 0.3882352941, alpha: 1)
            tableViewHeaderFooterView.textLabel?.textColor = UIColor.white
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return StringLanguage.p4_language.localized
        default:
            return StringLanguage.p4_other.localized
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
