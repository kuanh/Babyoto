//
//  HomeViewController.swift
//  BabyOto
//
//  Created by Developer on 8/2/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit
import AVFoundation
import os.log

struct Path {
    static var initialIndexPath : IndexPath? = nil
}

class HomeViewController: UIViewController, UINavigationBarDelegate {

    var audioPlayer: AVAudioPlayer!
    var toggleViewVolume: Bool = false
    var soundListsDefault: [String] = []
    var listSound = [Sound]()
    var listSoundAfterReoder = [Sound]()
    var listIndexPath: [Int] = []
    var manageSound = ManageSound.shared
    let volumeControl = VolumeControl.sharedInstance
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var displayNavigationBar: UIView!
    @IBOutlet var homeNavigationBar: UINavigationBar!
    @IBOutlet var showBarVolume: UIView!
    @IBOutlet weak var toggle: UIBarButtonItem!
    @IBOutlet weak var settingVolume: UISlider!
    @IBOutlet weak var clearView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isEditing = false
        
        // them navigationBar
        homeNavigationBar.topItem?.title = StringLanguage.app_name.localized
        displayNavigationBar.addSubview(homeNavigationBar)
        displayNavigationBar.addBorders(edges: [.bottom], color: #colorLiteral(red: 0.2196078431, green: 0.3411764706, blue: 0.5607843137, alpha: 1), width: 1)
        
        settingVolume.setThumbImage(UIImage(named: "knob"), for: .normal)
        
        tableView.separatorStyle = .none
        
        toggle.title = nil
        
        NotificationCenter.default.addObserver(self, selector: #selector(volumeChanged(note:)), name: NSNotification.Name("AVSystemController_SystemVolumeDidChangeNotification"), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        GoogleAdMob.sharedInstance.initializeBannerView()
        
        loadDataFrom(key: "sound")
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized))
        longPress.minimumPressDuration = 0.5
        tableView.isUserInteractionEnabled = true
        tableView.addGestureRecognizer(longPress)
        longPress.cancelsTouchesInView = true
        
        tableView.reloadData()
    }

    
    func loadDataFrom(key: String) {
        let arrDefault: [String] = ["p2_1tv","p2_2cleaner","p2_3dryer","p2_4vinyl","p2_5river","p2_6lightrain","p2_7heavyrain","p2_8wave","p2_9heart","p2_10water"]
        soundListsDefault = UserDefaults.standard.stringArray(forKey: key) ?? arrDefault
        soundListsDefault.forEach {[unowned self] item in
            if let sound = Sound(item) {
                self.listSound.append(sound)
            }
        }
        tableView.reloadData()
    }
    
    @objc func volumeChanged(note: NSNotification) {
        print(volumeControl.getVolume())
        settingVolume.value = volumeControl.getVolume()
    }
    
    // Xu ly thanh bar am luong
    @IBAction func slideAction(_ sender: UISlider) {
        volumeControl.setVolume(volume: settingVolume.value)
    }
    
    //Xu ly hien thi icon move khi tap lau vao 1 row
    @objc func longPressGestureRecognized(gestureRecognizer: UILongPressGestureRecognizer) {
        
        let locationInView = gestureRecognizer.location(in: self.tableView)
        guard let indexPath = self.tableView.indexPathForRow(at: locationInView) else { return }
        
        switch gestureRecognizer.state {
        case .began:
            if let cell = tableView.cellForRow(at: indexPath) as? HomeTableViewCell {
                if tableView.isEditing == false {
                    let backgroundImage: UIImageView = UIImageView(frame: cell.bounds)
                    let image: UIImage = UIImage(named: "btn_move")!
                    backgroundImage.image = image
                    cell.backgroundView = backgroundImage
                } else {
                    let backgroundImage: UIImageView = UIImageView(frame: cell.bounds)
                    let image: UIImage = UIImage(named: "btn_default")!
                    backgroundImage.image = image
                    cell.backgroundView = backgroundImage
                }
            }
        case .ended:
            tableView.isEditing == true ? tableView.setEditing(false, animated: true) : tableView.setEditing(true, animated: true)
        default:
            break
        }
    }
    
    //An va hien thanh bar am luong
    @IBAction func hideAndShowVolume(_ sender: UIBarButtonItem) {
        toggleViewVolume = toggleViewVolume == false ? true : false

        tableView.reloadData()
    }
    
    // Tam dung tat ca sound
    @IBAction func stopAllSound(_ sender: UIBarButtonItem) {
        let indexPaths = tableView.indexPathsForVisibleRows
        for indexPath in indexPaths! {
            manageSound.stopSounds(soundFileName: ["sound_\(listSound[indexPath.row].name)" ])
            let cell = tableView.cellForRow(at: indexPath) as! HomeTableViewCell
            cell.buttonPause.isHidden = true
            let backgroundImage: UIImageView = UIImageView(frame: cell.bounds)
            let image: UIImage = UIImage(named: "btn_default")!
            backgroundImage.image = image
            cell.backgroundView = backgroundImage
            listSound[indexPath.row].isPlaying = false
            listIndexPath.removeAll()
        }
        
        toggle.title = listIndexPath.count == 0 ? nil :  StringLanguage.p2_stop.localized
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listSound.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "soundCell", for: indexPath) as! HomeTableViewCell

            cell.nameSound.text = listSound[indexPath.row].name.localized
            cell.iconSound.image = "ico_\(listSound[indexPath.row].name)".loadIcon()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //Xu ly play and stop sound khi tap vao row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if listSound[indexPath.row].isPlaying == false {
            let cell = tableView.cellForRow(at: indexPath) as! HomeTableViewCell
            cell.buttonPause.isHidden = false
            listSound[indexPath.row].isPlaying = true
            listIndexPath.append(indexPath.row)
            toggle.title = StringLanguage.p2_stop.localized
            manageSound.playSound(soundFileName: "sound_\(listSound[indexPath.row].name)" )
            settingVolume.value = volumeControl.getVolume()
            
            // Thay doi background cua cell
            let backgroundImage: UIImageView = UIImageView(frame: cell.bounds)
            let image: UIImage = UIImage(named: "btn_pause")!
            backgroundImage.image = image
            cell.backgroundView = backgroundImage
        } else {
            let cell = tableView.cellForRow(at: indexPath) as! HomeTableViewCell
            cell.buttonPause.isHidden = true
            listSound[indexPath.row].isPlaying = false
            listIndexPath.remove(at: listIndexPath.index(of: indexPath.row)!)
            manageSound.stopSound(soundFileName: "sound_\(listSound[indexPath.row].name)" )
            toggle.title = listIndexPath.count == 0 ? nil :  StringLanguage.p2_stop.localized
            
            // Thay doi background cua cell
            let backgroundImage: UIImageView = UIImageView(frame: cell.bounds)
            let image: UIImage = UIImage(named: "btn_default")!
            backgroundImage.image = image
            cell.backgroundView = backgroundImage
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let addSeparatorThickness: CGFloat = 1
        let addSeparator: UIView = UIView(frame: CGRect(x: 0, y: cell.frame.size.height - addSeparatorThickness, width: cell.frame.size.width, height: addSeparatorThickness))
        addSeparator.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.3411764706, blue: 0.5607843137, alpha: 1)
        cell.addSubview(addSeparator)
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Xu ly sap xep lai indexPath
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        listSound.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        soundListsDefault.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        if listIndexPath.count != 0 {
            listIndexPath.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        }
        UserDefaults.standard.set(soundListsDefault, forKey: "sound")
    }
    
    // Hien thi thanh bar volume tren header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return showBarVolume
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return toggleViewVolume == true ? 44 : 0
    }
    
    
}
