
//
//  SelfTest1.swift
//  EmoClock
//
//  Created by 李博闻 on 2018/5/19.
//  Copyright © 2018年 艺林. All rights reserved.
//

import UIKit

class SelfTestOver: UIViewController {
    
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
    /* display point */
    var point: CGFloat = 0.0
    
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
            
            let label = UILabel.init(frame: CGRect.init(x: 0, y: 53, width: self.frameWidth, height: 24))
            label.textColor = UIColor.white
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.systemFont(ofSize: 16)
            label.text = "起床心情自测"
            barView.addSubview(label)
            
            let itemImageLeft = UIImage.init(named: "back")
            let btnLeft = UIButton.init(frame: CGRect.init(x: 15, y: 56, width: 47 * self.ratioWidth, height: 21 * self.ratioHeight))
            btnLeft.setImage(itemImageLeft, for: UIControlState.normal)
            barView.addSubview(btnLeft)
            btnLeft.addTarget(self, action: #selector(back), for: .touchUpInside)
            
            self.view.addSubview(barView)
        }
        else
        {
            let barView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frameWidth, height: 64.5*self.ratioHeight))
            barView.backgroundColor = self.backColor
            
            let label = UILabel.init(frame: CGRect.init(x: 0, y: 34.5*self.ratioHeight, width: self.frameWidth, height: 15.5*self.ratioHeight))
            label.textAlignment = .center
            label.textColor = UIColor.white
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
            label.text = "起床心情自测"
            barView.addSubview(label)
            
            let itemImageLeft = UIImage.init(named: "back")
            let btnLeft = UIButton.init(frame: CGRect.init(x: 18 * self.ratioWidth, y: 32 * self.ratioHeight, width: 47 * self.ratioWidth, height: 21 * self.ratioHeight))
            btnLeft.setImage(itemImageLeft, for: UIControlState.normal)
            barView.addSubview(btnLeft)
            btnLeft.addTarget(self, action: #selector(back), for: .touchUpInside)
            
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
        let label1 = UILabel.init(frame: CGRect.init(x: 0, y: 70.5 * self.ratioHeight, width: self.frameWidth, height: 35.5 * self.ratioHeight))
        label1.text = "恭喜！已完成起床心情自测"
        label1.font = UIFont.boldSystemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 25))
        label1.textAlignment = .center
        label1.textColor = UIColor.white
        bottomView.addSubview(label1)
        // label 2
        let label2 = UILabel.init(frame: CGRect.init(x: 0, y: 116.5 * self.ratioHeight, width: self.frameWidth, height: 21.5 * self.ratioHeight))
        label2.text = "当前平均起床情感状态："
        label2.font = UIFont.boldSystemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
        label2.textAlignment = .center
        label2.textColor = UIColor.white
        bottomView.addSubview(label2)
        // label 3
        let label3 = UILabel.init(frame: CGRect.init(x: 0, y: 146 * self.ratioHeight, width: self.frameWidth, height: 42 * self.ratioHeight))
        label3.text = String(format: "%.1f", self.point)
        label3.font = UIFont.boldSystemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 30))
        label3.textAlignment = .center
        label3.textColor = UIColor.white
        bottomView.addSubview(label3)
        // label 4
        let label4 = UILabel.init(frame: CGRect.init(x: 0, y: 197 * self.ratioHeight, width: self.frameWidth, height: 27.5 * self.ratioHeight))
        label4.text = "坚持使用三个月后，起床心情会有明显改善哦 ：）"
        label4.font = UIFont.boldSystemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
        label4.textAlignment = .center
        label4.textColor = UIColor.white
        bottomView.addSubview(label4)
        // button 1
        let button1 = UIButton.init(frame: CGRect(x: 46.5 * self.ratioWidth, y: 393.5 * self.ratioHeight, width: 280 * self.ratioWidth, height: 57.5 * self.ratioHeight))
        button1.setTitle("好的", for: .normal)
        button1.setTitleColor(UIColor.white, for: .normal)
        button1.setTitleColor(UIColor.gray, for: .highlighted)
        button1.titleLabel?.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 20))
        button1.backgroundColor = UIColor.init(red: 50/255, green: 136/255, blue: 1, alpha: 1) //3288ff
        button1.layer.cornerRadius = 32 * self.ratioWidth
        bottomView.addSubview(button1)
        button1.addTarget(self, action: #selector(gotoNext), for: .touchUpInside)
        // button 2
        let button2 = UIButton.init(frame: CGRect(x: 0 * self.ratioWidth, y: 500.5 * self.ratioHeight, width: self.frameWidth, height: 21.5 * self.ratioHeight))
        button2.setTitle("再测一次", for: .normal)
        //button2.setTitleColor(UIColor.white, for: .normal)
        //button2.setTitleColor(UIColor.gray, for: .selected)
        button2.titleLabel?.font = UIFont.boldSystemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
        button2.titleLabel?.textAlignment = .center
        button2.setTitleColor(UIColor.init(red: 50/255, green: 136/255, blue: 1, alpha: 1), for: .normal)
        button2.setTitleColor(UIColor.gray, for: .highlighted)
        bottomView.addSubview(button2)
        button2.addTarget(self, action: #selector(tapAgain), for: .touchUpInside)
        
        self.view.addSubview(bottomView)
    }
    
    @objc func tapAgain() {
        self.navigationController?.pushViewController(SelfTest1(), animated: true)
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func gotoNext() {
        
        let path = StoreFileManager.getStoragePath(suffix: "/EmoClock/AlarmInfo/")
        let filePath = path + "info.txt"
        //let content = NSArray.init(contentsOf: URL.init(string: "file://"+filePath)!)
        let content = StoreFileManager.readFileAtPath(path: filePath)
        print(filePath)
        
        if !content.isEmpty { //having a clock
            
            //let vc = sb.instantiateViewController(withIdentifier: "AddClock")
            let alarmInfo = content[0] as! Dictionary<String, Any>
            let clockMonth = alarmInfo["alarmMonth"] as! Int
            let clockDay = alarmInfo["alarmDay"] as! Int
            let clockHour = alarmInfo["alarmHour"] as! Int
            let clockMin = alarmInfo["alarmMinute"] as! Int
            let clockYear = alarmInfo["alarmYear"] as! Int
            let clock_range = alarmInfo["alarm_range"] as! String
            let today = alarmInfo["today"] as! Bool
            
            let ad = AddClock()
            ad.time_range = clock_range
            ad.clock_hour = clockHour
            ad.clock_minute = clockMin
            ad.clock_month = clockMonth
            ad.clock_day = clockDay
            ad.weekday = alarmInfo["alarmWeek"] as! Int
            ad.remainTime = alarmInfo["time_remain"] as! Double
            ad.init_flag = true
            ad.today = today
            self.navigationController?.pushViewController(ad, animated: true)
            
        } else { //没有闹钟
            let mp = MainPage()
            mp.flag = false
            self.navigationController?.pushViewController(mp, animated: true)
        }
        
        
    }
}
