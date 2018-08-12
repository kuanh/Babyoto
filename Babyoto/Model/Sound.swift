//
//  Sound.swift
//  BabyOto
//
//  Created by Developer on 8/2/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class Sound {
    var name: String
    var isPlaying: Bool
    
    init?(_ name: String, isPlaying: Bool = false) {
        guard !name.isEmpty else { return nil }
        
        self.name = name
        self.isPlaying = isPlaying
    }
}
