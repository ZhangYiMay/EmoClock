//
//  SelfTestAlert.swift
//  EmoClock
//
//  Created by 李博闻 on 2018/5/19.
//  Copyright © 2018年 艺林. All rights reserved.
//

import UIKit

class SelfTestAlert: UIAlertController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rect = CGRect.init(x: 0, y: 0, width: 300 , height: 324.5 )
        self.view.frame = rect
        self.view.backgroundColor = UIColor.red
    }
}
