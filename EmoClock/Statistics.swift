//
//  Statistics.swift
//  EmoClock
//
//  Created by 李博闻 on 2018/3/5.
//  Copyright © 2018年 艺林. All rights reserved.
//

import UIKit

class Statistics: UIViewController {
    
    /* global var: the size of the frame */
    var frameHeight: CGFloat = 0.0
    var frameWidth: CGFloat = 0.0
    /* global var: the ratio of the current frame */
    var ratioWidth: CGFloat = 0.0
    var ratioHeight: CGFloat = 0.0
    /* global color */
    let backColor = UIColor.init(red: 0.0, green: 33/255, blue: 49/255, alpha: 1.0)
    /* iphone6 frame width and height*/
    let IPHONE6_WIDTH: CGFloat = 375.0
    let IPHONE6_HEIGHT: CGFloat = 667.0
    /* points */
    var averageSleepingTime: Float = 0.0
    var averageHappyPoint: Float = 0.0
    var totalDays: Int = 0
    /* platform */
    let platform = UIDevice.current.modelName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.navigationBar.isHidden = true
        /* get the size of the frame */
        self.frameHeight = self.view.frame.height
        self.frameWidth = self.view.frame.width
        self.ratioWidth = self.frameWidth / IPHONE6_WIDTH
        self.ratioHeight = self.frameHeight / IPHONE6_HEIGHT
        if self.ratioWidth < self.ratioHeight {
            self.ratioHeight = self.ratioWidth
        } else {
            self.ratioWidth = self.ratioHeight
        }
        self.view.backgroundColor = UIColor.gray
        
        setNavBarStyle()
        readAndShowAverageSleepingTime()
        readAndShowHappyPoint()
        readAndShowTotalDays()
        setStatiticView()
        
    }
    
    func readAndShowAverageSleepingTime() {
        let filePath = StoreFileManager.getStoragePath(suffix: "/EmoClock/SleepTime/") + "average.txt"
        let content = StoreFileManager.readFileAtPath(path: filePath) as! Array<Dictionary<String, Any>>
        if !(content.isEmpty) {
            let info = content[0]
            let totalTime = info["total"] as! Double
            let count = info["count"] as! Double
            if count != 0 {
                self.averageSleepingTime = Float(totalTime / count)
            } else {
                self.averageSleepingTime = 0.0
            }
            
        }
    }
    
    func readAndShowTotalDays() {
        let filePath = StoreFileManager.getStoragePath(suffix: "/EmoClock/FirstUse/") + "date.txt"
        let content = StoreFileManager.readFileAtPath(path: filePath) as! Array<Double>
        if (!content.isEmpty) {
            let beginTime = content[0]
            let now = NSDate()
            let nowTime = now.timeIntervalSince1970
            self.totalDays = Int((nowTime - beginTime)/(3600 * 24)) + 1
        }
    }
    
    func readAndShowHappyPoint() {
        let filePath = StoreFileManager.getStoragePath(suffix: "/EmoClock/Points/") + "happy.txt"
        var content = StoreFileManager.readFileAtPath(path: filePath) as! Array<Float>
        if (!content.isEmpty) {
            let endIdx = content.endIndex
            var sum: Float = 0.0
            for var i in 0..<endIdx {
                if content[i] < 1.0 {
                    content[i] = 1.0
                }
                sum += content[i]
            }
            self.averageHappyPoint = sum/Float(endIdx)
        }
    }
    
    func setNavBarStyle() {
        if platform == "iPhone X" || (frameWidth == 375.0 && frameHeight == 812.0)
        {
            let barView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frameWidth, height: 89))
            barView.backgroundColor = self.backColor
            
            //let label = UILabel.init(frame: CGRect.init(x: 172*self.ratioWidth, y: 34.5*self.ratioHeight, width: 31*self.ratioWidth, height: 15.5*self.ratioHeight))
            let label = UILabel.init(frame: CGRect.init(x: 0, y: 53, width: self.frameWidth, height: 15.5*self.ratioHeight))
            label.textAlignment = .center
            label.textColor = UIColor.white
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
            label.text = "统计"
            barView.addSubview(label)
            
            let itemImageLeft = UIImage.init(named: "back")
            let btnLeft = UIButton.init(frame: CGRect.init(x: 15, y: 55, width: 47 * self.ratioWidth, height: 21 * self.ratioHeight))
            btnLeft.setImage(itemImageLeft, for: UIControlState.normal)
            barView.addSubview(btnLeft)
            btnLeft.addTarget(self, action: #selector(tapBack), for: .touchUpInside)
            
            self.view.addSubview(barView)
        } else {
            let barView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frameWidth, height: 64.5*self.ratioHeight))
            barView.backgroundColor = self.backColor
            
            //let label = UILabel.init(frame: CGRect.init(x: 172*self.ratioWidth, y: 34.5*self.ratioHeight, width: 31*self.ratioWidth, height: 15.5*self.ratioHeight))
            let label = UILabel.init(frame: CGRect.init(x: 0, y: 34.5*self.ratioHeight, width: self.frameWidth, height: 15.5*self.ratioHeight))
            label.textAlignment = .center
            label.textColor = UIColor.white
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
            label.text = "统计"
            barView.addSubview(label)
            
            let itemImageLeft = UIImage.init(named: "back")
            let btnLeft = UIButton.init(frame: CGRect.init(x: 18 * self.ratioWidth, y: 32 * self.ratioHeight, width: 47 * self.ratioWidth, height: 21 * self.ratioHeight))
            btnLeft.setImage(itemImageLeft, for: UIControlState.normal)
            barView.addSubview(btnLeft)
            btnLeft.addTarget(self, action: #selector(tapBack), for: .touchUpInside)
            
            self.view.addSubview(barView)
        }
        
    }
    
    func setStatiticView() {
        var remainView = UIView.init()
        if platform == "iPhone X" || (frameWidth == 375.0 && frameHeight == 812.0)
        {
            remainView = UIView.init(frame: CGRect.init(x: 0, y: 89.5, width: self.frameWidth, height: self.frameHeight - 65.0 * self.ratioHeight))
        } else {
            remainView = UIView.init(frame: CGRect.init(x: 0, y: 65.0 * self.ratioHeight, width: self.frameWidth, height: self.frameHeight - 65.0 * self.ratioHeight))
        }
        
        remainView.backgroundColor = self.backColor
        // label: total using days - data
        //let label_num = UILabel.init(frame: CGRect.init(x: 146 * self.ratioWidth, y: 27 * self.ratioHeight, width: 83 * self.ratioWidth, height: 52 * self.ratioHeight))
        let label_num = UILabel.init(frame: CGRect.init(x: 0, y: 27 * self.ratioHeight, width: self.frameWidth, height: 52 * self.ratioHeight))
        label_num.textAlignment = .center
        label_num.text = "\(self.totalDays)"
        label_num.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 50))
        label_num.textColor = UIColor.white
        remainView.addSubview(label_num)
        // label: total using days
        //let label_days = UILabel.init(frame: CGRect.init(x: 149.5 * self.ratioWidth, y: 79 * self.ratioHeight, width: 76.5 * self.ratioWidth, height: 15.5 * self.ratioHeight))
        let label_days = UILabel.init(frame: CGRect.init(x: 0, y: 79 * self.ratioHeight, width: self.frameWidth, height: 15.5 * self.ratioHeight))
        label_days.textAlignment = .center
        label_days.text = "总使用天数"
        label_days.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
        label_days.textColor = UIColor.white
        remainView.addSubview(label_days)
        // label: average sleeping time - data
        let label_sleep = UILabel.init(frame: CGRect.init(x: 43.5/*60.5*/ * self.ratioWidth, y: 117.5 * self.ratioHeight, width: /*29.5*/ 64.5 * self.ratioWidth, height: 21 * self.ratioHeight))
        label_sleep.textAlignment = .center
        label_sleep.text = String(format: "%.1f", self.averageSleepingTime)
        label_sleep.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 20))
        label_sleep.textColor = UIColor.white
        remainView.addSubview(label_sleep)
        // label: average sleeping time
        let label_sleeping = UILabel.init(frame: CGRect.init(x: 43.5 * self.ratioWidth, y: 141 * self.ratioHeight, width: self.frameWidth/2/*64.5 * self.ratioWidth*/, height: 11 * self.ratioHeight))
        label_sleeping.textAlignment = .left
        label_sleeping.text = "平均睡眠时间"
        label_sleeping.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 10))
        label_sleeping.textColor = UIColor.white
        remainView.addSubview(label_sleeping)
        // label: average emotion condition - data
        let label_emo = UILabel.init(frame: CGRect.init(x: 267.5/*284*/ * self.ratioWidth, y: 117.5 * self.ratioHeight, width: 64.5/*30.5*/ * self.ratioWidth, height: 21 * self.ratioHeight))
        label_emo.textAlignment = .center
        label_emo.text = String(format: "%.1f", self.averageHappyPoint)
        label_emo.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 20))
        label_emo.textColor = UIColor.white
        remainView.addSubview(label_emo)
        // label: average emotion condition
        let label_emotion = UILabel.init(frame: CGRect.init(x: 267.5 * self.ratioWidth, y: 141 * self.ratioHeight, width: self.frameWidth / 2/*64.5 * self.ratioWidth*/, height: 11 * self.ratioHeight))
        label_emotion.textAlignment = .left
        label_emotion.text = "平均情感状态"
        label_emotion.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 10))
        label_emotion.textColor = UIColor.white
        remainView.addSubview(label_emotion)
        // imageView
        let iv = UIImageView.init(frame: CGRect.init(x: 18 * self.ratioWidth, y: 207.5 * self.ratioHeight, width: 339.5 * self.ratioWidth, height: 183 * self.ratioHeight))
        //iv.backgroundColor = UIColor.gray
        remainView.addSubview(iv)
        
        let line = UIView.init(frame: CGRect.init(x: 18 * self.ratioWidth, y: 398 * self.ratioHeight, width: 339.5 * self.ratioWidth, height: 1.5 * self.ratioHeight))
        line.backgroundColor = UIColor.init(white: 1, alpha: 0.2)
        remainView.addSubview(line)
        let week = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
        let x: [CGFloat] = [18, 74.5, 127, 182, 235.5, 283, 334.5]
        //let width: [CGFloat] = [25.5, 21.5, 24.5, 22.5, 16.5, 21, 22.5]
        let width: [CGFloat] = [30, 30, 30, 30, 30, 30, 30]
        for var i in 0..<7 {
            let label = UILabel.init(frame: CGRect.init(x: x[i] * self.ratioWidth, y: 413 * self.ratioHeight, width: width[i] * self.ratioWidth, height: 14.5 * self.ratioHeight))
            label.text = week[i]
            if i < 6 {
                label.textColor = UIColor.init(white: 1, alpha: 0.8)
            } else {
                label.textColor = UIColor.init(red: 50 / 255, green: 136 / 255, blue: 1, alpha: 0.8)
            }
            label.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 10.5))
            remainView.addSubview(label)
        }
        
        self.view.addSubview(remainView)
    }
    
    @objc func tapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
