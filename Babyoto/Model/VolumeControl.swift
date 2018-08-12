//
//  VolumeControl.swift
//  BabyOto
//
//  Created by Developer on 8/7/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import MediaPlayer
import AVFoundation

class VolumeControl {
    static let sharedInstance : VolumeControl = VolumeControl()
    
    private var sliderView : UISlider!
    private var volumeView : MPVolumeView
    
    let audioSession = AVAudioSession.sharedInstance()

    private init()
    {
        let controller = UIApplication.shared.delegate?.window!?.rootViewController

        let wrapper = UIView(frame: CGRect(x: 30,y: 200,width: 260,height: 20))
        wrapper.backgroundColor = .clear
        controller!.view.addSubview(wrapper)

        volumeView = MPVolumeView(frame: wrapper.bounds)
        volumeView.isHidden = true
        for subview in volumeView.subviews
        {
            if let slider = subview as? UISlider {
                sliderView = slider
            }
        }
        wrapper.addSubview(volumeView)
        if (sliderView == nil)
        {
            NSLog("Error: Error setting up Volume Controller")
        }
    }
    
    func setVolume(volume: Float) {
        do {
            try audioSession.setActive(true)
            if sliderView != nil {
                sliderView.setValue(volume, animated: false)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getVolume() -> Float
    {
        do{
            try audioSession.setActive(true)
            let audioVolume = audioSession.outputVolume
            let audioVolumePercentage = audioVolume
            return audioVolumePercentage
        }catch{
            print("Error while getting volume level \(error)")
        }
        return 0
    }
}

