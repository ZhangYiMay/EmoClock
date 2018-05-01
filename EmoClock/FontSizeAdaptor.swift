//
//  FontSizeAdaptor.swift
//  EmoClock
//
//  Created by 李博闻 on 2018/4/23.
//  Copyright © 2018年 艺林. All rights reserved.
//

import UIKit

class FontSizeAdaptor {
    
    static func adaptFontSize(fontSize: CGFloat) -> CGFloat {
        let frameWidth = UIApplication.shared.keyWindow?.frame.width
        //let frameHeight = UIApplication.shared.keyWindow?.frame.height
        if frameWidth == 320.0 {
            return (fontSize - 2)
        } else if frameWidth == 375.0 {
            return fontSize
        } else {
            print("other framewidth condition")
            // continue to add
            return (fontSize + 2)
        }
    }
}
