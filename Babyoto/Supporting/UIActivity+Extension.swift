//
//  UIActivity+Extension.swift
//  BabyOto
//
//  Created by Developer on 8/3/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

extension SettingViewController: UIActivityItemSource {
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return ""
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivityType?) -> Any? {
        if activityType == UIActivityType.postToFacebook {
            return "String for Facebook"
        }
        return nil
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivityType?) -> String {
        if activityType == UIActivityType.postToFacebook {
            return "Subject for Facebook"
        }
        return ""
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, thumbnailImageForActivityType activityType: UIActivityType?, suggestedSize size: CGSize) -> UIImage? {
        if activityType == UIActivityType.postToFacebook {
            return UIImage(named: "ico_fb")
        }
        return UIImage(named: "ico_mail")
    }
}
