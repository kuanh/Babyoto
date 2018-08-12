//
//  ManageSound.swift
//  BabyOto
//
//  Created by Developer on 8/6/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import AVFoundation
import MediaPlayer

class ManageSound: NSObject, AVAudioPlayerDelegate {
    
    static let shared: ManageSound = ManageSound()
    
    private var soundFileNameURL: URL?
    private var players = [URL:AVAudioPlayer]()
    private var duplicatePlayers = [URL:AVAudioPlayer]()
    
    //Xu ly play sound
    func playSound (soundFileName: String) {
        
        soundFileNameURL = URL(fileURLWithPath: Bundle.main.path(forResource: soundFileName, ofType: "mp3")!)
        
        if let player = players[soundFileNameURL!] {
            if player.isPlaying == false {
                player.numberOfLoops = -1
                player.prepareToPlay()
                player.play()
            }
        } else {
            do{
                let player = try AVAudioPlayer(contentsOf: soundFileNameURL!)
                players[soundFileNameURL!] = player
                player.prepareToPlay()
                player.play()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //xu ly stop sound
    
    func stopSound (soundFileName: String) {
        soundFileNameURL = URL(fileURLWithPath: Bundle.main.path(forResource: soundFileName, ofType: "mp3")!)
        
        if let player = players[soundFileNameURL!] {
            if player.isPlaying == true {
                player.stop()
            } else {
                let duplicatePlayer = duplicatePlayers[soundFileNameURL!]
                if duplicatePlayer?.isPlaying == true {
                    duplicatePlayer?.stop()
                }
                duplicatePlayers.removeValue(forKey: soundFileNameURL!)
            }
        } else {
            do{
                let player = try AVAudioPlayer(contentsOf: soundFileNameURL!)
                players[soundFileNameURL!] = player
                player.stop()
            } catch {
                print("Could not play sound file!")
            }
        }
        print(duplicatePlayers.count)
    }
    
    //xu ly stop tat ca cac sound
    func stopSounds (soundFileName : [String]) {
        for soundfileName in soundFileName {
            stopSound(soundFileName: soundfileName)
        }
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if let index = duplicatePlayers.index(forKey: soundFileNameURL!){
            duplicatePlayers.remove(at: index)
        }
        player.stop()
    }
}
