//
//  UISlider+Extension.swift
//  Babyoto
//
//  Created by KuAnh on 11/08/2018.
//  Copyright © 2018 KuAnh. All rights reserved.
//

import UIKit

extension UISlider {
    func trackRect(forBounds bounds: CGRect) -> CGRect {
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 5.0))
        return customBounds
    }
    
    var thumbCenterX: CGFloat {
        let track = self.trackRect(forBounds: frame)
        let thumbRect = self.thumbRect(forBounds: bounds, trackRect: track, value: value)
        return thumbRect.minX
    }
}
