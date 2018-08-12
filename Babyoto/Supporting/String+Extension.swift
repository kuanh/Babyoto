//
//  String+Extension.swift
//  BabyOto
//
//  Created by Developer on 7/31/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

extension String {
    enum Language: String {
        case english = "English"
        case chinese = "日本語"
        case thailand = "ภาษาไทย"
        case japanese = "中文"
        case vietnamese = "Tiếng Việt"
        
        static let values = [chinese, english, japanese, thailand, vietnamese]
    }
    
    var localized: String {
        var currentLocale = ""
        if let locate = UserDefaults.standard.object(forKey: "locate") as? String {
            currentLocale = locate
            
        } else {
            currentLocale = "Base"
        }
        UserDefaults.standard.set(currentLocale, forKey: "locate")
        guard
            let bundlePath = Bundle.main.path(forResource: currentLocale, ofType: "lproj"),
            let bundle = Bundle(path: bundlePath) else {
                return self
        }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
