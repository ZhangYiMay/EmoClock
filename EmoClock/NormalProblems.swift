//
//  NormalProblems.swift
//  EmoClock
//
//  Created by 李博闻 on 2018/5/19.
//  Copyright © 2018年 艺林. All rights reserved.
//

import UIKit

class NormalProbles: UIViewController {
    
    /* global var: the size of the frame */
    var frameHeight: CGFloat = 0.0
    var frameWidth: CGFloat = 0.0
    /* global var: the ratio of the current frame */
    var ratioWidth: CGFloat = 0.0
    var ratioHeight: CGFloat = 0.0
    var backup: CGFloat = 0.0
    /* global color */
    let backColor = UIColor.init(red: 0.0, green: 33/255, blue: 49/255, alpha: 1.0)
    /* iphone6 frame width and height*/
    let IPHONE6_WIDTH: CGFloat = 375.0
    let IPHONE6_HEIGHT: CGFloat = 667.0
    /* platform */
    let platform = UIDevice.current.modelName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        //        let bundlePath = Bundle.main.path(forResource: "shape of you", ofType: "m4a")
        //        print("bundlePath:\(bundlePath)")
        /* get the size of the frame */
        self.frameHeight = self.view.frame.height
        self.frameWidth = self.view.frame.width
        self.ratioWidth = self.frameWidth / IPHONE6_WIDTH
        self.ratioHeight = self.frameHeight / IPHONE6_HEIGHT
        if self.ratioWidth < self.ratioHeight {
            self.backup = self.ratioHeight
            self.ratioHeight = self.ratioWidth
        } else {
            self.backup = self.ratioWidth
            self.ratioWidth = self.ratioHeight
        }
        self.view.backgroundColor = UIColor.gray
        print("framewidth: \(self.frameWidth), frameheight: \(self.frameHeight)")
        
        /* set the ui of navigation bar */
        setNavBarStyle()
        /* set the ui of remaining view */
        setBottomView()
    }
    
    func setNavBarStyle() {
        
        if platform == "iPhone X" || (frameWidth == 375.0 && frameHeight == 812.0)
        {
            let barView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frameWidth, height: 89))
            barView.backgroundColor = self.backColor
            
            let label = UILabel.init(frame: CGRect.init(x: 146, y: 53, width: 83, height: 24))
            label.textColor = UIColor.white
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.systemFont(ofSize: 16)
            label.text = "EmoClock"
            barView.addSubview(label)
            
            let itemImageLeft = UIImage.init(named: "back")
            let btnLeft = UIButton.init(frame: CGRect.init(x: 15, y: 55, width: 47, height: 20))
            //let btnLeft = UIButton.init(frame: CGRect.init(x: 15 * self.ratioWidth, y: 32 * self.ratioHeight, width: 30 * self.ratioWidth, height: 30 * self.ratioHeight)) //test
            btnLeft.setImage(itemImageLeft, for: UIControlState.normal)
            barView.addSubview(btnLeft)
            btnLeft.addTarget(self, action: #selector(tapBack), for: .touchUpInside)

            self.view.addSubview(barView)
        }
        else
        {
            let barView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frameWidth, height: 64.5*self.ratioHeight))
            barView.backgroundColor = self.backColor
            
            let label = UILabel.init(frame: CGRect.init(x: 151*self.ratioWidth, y: 34.5*self.ratioHeight, width: 73*self.ratioWidth, height: 15.5*self.ratioHeight))
            label.textColor = UIColor.white
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
            label.text = "EmoClock"
            barView.addSubview(label)
            
            let itemImageLeft = UIImage.init(named: "back")
            let btnLeft = UIButton.init(frame: CGRect.init(x: 15 * self.ratioWidth, y: 32 * self.ratioHeight, width: 47 * self.ratioWidth, height: 20 * self.ratioHeight))
            //let btnLeft = UIButton.init(frame: CGRect.init(x: 15 * self.ratioWidth, y: 32 * self.ratioHeight, width: 30 * self.ratioWidth, height: 30 * self.ratioHeight)) //test
            btnLeft.setImage(itemImageLeft, for: UIControlState.normal)
            barView.addSubview(btnLeft)
            btnLeft.addTarget(self, action: #selector(tapBack), for: .touchUpInside)
            self.view.addSubview(barView)
        }
    }
    
    func setBottomView() {
        var bottomView = UIView.init()
        if platform == "iPhone X" || (frameWidth == 375.0 && frameHeight == 812.0)
        {
            bottomView = UIView.init(frame: CGRect.init(x: 0, y: 89.5 * self.ratioHeight, width: self.frameWidth, height: self.frameHeight - 89.5 * self.ratioHeight))
        }
        else
        {
            bottomView = UIView.init(frame: CGRect.init(x: 0, y: 65.0 * self.ratioHeight, width: self.frameWidth, height: self.frameHeight - 65.0 * self.ratioHeight))
        }
        bottomView.backgroundColor = self.backColor
        //label 1
        let label1 = UILabel.init(frame: CGRect.init(x: 18 * self.ratioWidth, y: 19.5 * self.ratioHeight, width: 339.5 * self.ratioWidth, height: 63.5 * self.ratioHeight))
        label1.text = "1.为了保重闹钟的正常运行，使用过程中请勿开启【勿扰模式】，请勿【静音】。如有需要，您可以使用飞行模式哦 ：）"
        label1.numberOfLines = 3
        label1.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
        label1.textColor = UIColor.white
        bottomView.addSubview(label1)
        // image 1
        let iv1 = UIImageView.init(frame: CGRect.init(x: 68.5 * self.ratioWidth, y: 172 * self.ratioHeight, width: 89 * self.ratioWidth, height: 45.5 * self.ratioHeight))
        iv1.image = UIImage.init(named: "pro1")
        bottomView.addSubview(iv1)
        // image 2
        let iv2 = UIImageView.init(frame: CGRect.init(x: 257 * self.ratioWidth, y: 167.5 * self.ratioHeight, width: 45.5 * self.ratioWidth, height: 49.5 * self.ratioHeight))
        iv2.image = UIImage.init(named: "pro2")
        bottomView.addSubview(iv2)
        // label 2
        let label2 = UILabel.init(frame: CGRect.init(x: 41 * self.ratioWidth, y: 252 * self.ratioHeight, width: 200 * self.ratioWidth, height: 20 * self.ratioHeight))
        label2.text = "请勿使用静音和勿扰模式"
        label2.font = UIFont.boldSystemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 13.5))
        label2.textColor = UIColor.init(red: 50/255, green: 136/255, blue: 1, alpha: 1) //#3288ff;
        bottomView.addSubview(label2)
        // label 3
        let label3 = UILabel.init(frame: CGRect.init(x: 224 * self.ratioWidth, y: 252 * self.ratioHeight, width: 150 * self.ratioWidth, height: 20 * self.ratioHeight))
        label3.text = "推荐使用飞行模式"
        label3.font = UIFont.boldSystemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 13.5))
        label3.textColor = UIColor.init(red: 50/255, green: 136/255, blue: 1, alpha: 1) //#3288ff;
        bottomView.addSubview(label3)
        //label 4
        let label4 = UILabel.init(frame: CGRect.init(x: 18 * self.ratioWidth, y: 331 * self.ratioHeight, width: 339.5 * self.ratioWidth, height: 63.5 * self.ratioHeight))
        label4.text = "2.为了保重闹钟的正常运行，请开启通知哦 ：）通知开启方式：设置-通知-EmoClock-允许通知"
        label4.numberOfLines = 3
        label4.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
        label4.textColor = UIColor.white
        bottomView.addSubview(label4)
        //label 5
        let label5 = UILabel.init(frame: CGRect.init(x: 18 * self.ratioWidth, y: 461.5 * self.ratioHeight, width: 339.5 * self.ratioWidth, height: 63.5 * self.ratioHeight))
        label5.text = "3.每天的反馈，只为更懂你。根据您每天关闭闹钟后的反馈，我们回调整第二天的闹钟音乐，努力找到最适合您的起床铃声 ：）"
        label5.numberOfLines = 3
        label5.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
        label5.textColor = UIColor.white
        bottomView.addSubview(label5)
        self.view.addSubview(bottomView)
    }
    
    @objc func tapBack () {
        self.navigationController?.popViewController(animated: true)
    }
}
