//
//  MainPage.swift
//  EmoClock
//
//  Created by 李博闻 on 2018/3/3.
//  Copyright © 2018年 艺林. All rights reserved.
//
//  首页

import UIKit
import AVFoundation

class MainPage: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    /* global var: the size of the frame */
    var frameHeight: CGFloat = 0.0
    var frameWidth: CGFloat = 0.0
    /* global var: the ratio of the current frame */
    var ratioWidth: CGFloat = 0.0
    var ratioHeight: CGFloat = 0.0
    var backup: CGFloat = 0.0
    /* global color */
    let backColor = UIColor.init(red: 0.0, green: 33/255, blue: 49/255, alpha: 1.0)
    /* clock setting */
    var clock_hour = 0
    var clock_minute = 0
    var time_range = "AM"
    var remainTime: Double = 0
    /* iphone6 frame width and height*/
    let IPHONE6_WIDTH: CGFloat = 375.0
    let IPHONE6_HEIGHT: CGFloat = 667.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = true
        let bundlePath = Bundle.main.path(forResource: "shape of you", ofType: "m4a")
        print("bundlePath:\(bundlePath)")
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
        
        /* set the background of the picker view */
        setPickerStyle()
        
        /* set the bottom view */
        setBottomView()
        
        /* record first launched time */
        recordFirstLaunched()
    }
    
    func recordFirstLaunched() {
        let first: Bool = UserDefaults.standard.bool(forKey: "firstLauched")
        if first {
            let now = NSDate()
            let timeNow = now.timeIntervalSince1970
            let path = StoreFileManager.getStoragePath(suffix: "/EmoClock/FirstUse/")
            let filePath = path + "date.txt"
            let dateArr = [timeNow]
            StoreFileManager.storeFileToPath(path: filePath, info: NSArray.init(array: dateArr))
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
    func setNavBarStyle() {
        let barView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frameWidth, height: 64.5*self.ratioHeight))
        barView.backgroundColor = self.backColor
        
        let label = UILabel.init(frame: CGRect.init(x: 151*self.ratioWidth, y: 34.5*self.ratioHeight, width: 73*self.ratioWidth, height: 15.5*self.ratioHeight))
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
        label.text = "EmoClock"
        barView.addSubview(label)
        
        let itemImageLeft = UIImage.init(named: "statistics")
        let btnLeft = UIButton.init(frame: CGRect.init(x: 15 * self.ratioWidth, y: 32 * self.ratioHeight, width: 23.5 * self.ratioWidth, height: 20 * self.ratioHeight))
        btnLeft.setImage(itemImageLeft, for: UIControlState.normal)
        barView.addSubview(btnLeft)
        btnLeft.addTarget(self, action: #selector(tapStatistics), for: .touchUpInside)
        
        let itemImageRight = UIImage.init(named: "set")
        let btnRight = UIButton.init(frame: CGRect.init(x: 335 * self.ratioWidth, y: 28 * self.ratioHeight, width: 28 * self.ratioWidth, height: 28 * self.ratioHeight))
        btnRight.setImage(itemImageRight, for: UIControlState.normal)
        barView.addSubview(btnRight)
        btnRight.addTarget(self, action: #selector(tapSetting), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(barView)
    }
    
    func setPickerStyle() {
        let pickerBackView = UIView.init(frame: CGRect.init(x: 0, y: 65.0 * self.ratioHeight, width: self.frameWidth, height: self.frameHeight - 65.0 * self.ratioHeight))
        pickerBackView.backgroundColor = self.backColor
        let imView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.frameWidth, height: 446.0 * self.ratioHeight))
        imView.image = UIImage.init(named: "background")
        pickerBackView.addSubview(imView)
        let picker = UIPickerView.init(frame: CGRect.init(x: 117 * self.ratioWidth, y: 84 * self.ratioHeight, width: 140.5 * self.ratioWidth, height: 218.5 * self.ratioHeight))
        picker.delegate = self
        picker.dataSource = self
        pickerBackView.addSubview(picker)
        self.view.addSubview(pickerBackView)
    }
    
    func setBottomView() {
        let bottomRect = CGRect.init(x: 0, y: 511 * self.ratioHeight, width: self.frameWidth, height: self.frameHeight - 511 * self.ratioHeight)
        let bottomView = UIView.init(frame: bottomRect)
        bottomView.backgroundColor = self.backColor
        
        let btnRect = CGRect.init(x: 46.5 * self.ratioWidth, y: 0, width: 280 * self.ratioWidth, height: 57 * self.ratioHeight)
        let buttonStart = UIButton.init(frame: btnRect)
        buttonStart.layer.masksToBounds = true
        buttonStart.layer.cornerRadius = 30 * self.ratioWidth
        buttonStart.backgroundColor = UIColor.init(red: 50/255, green: 136/255, blue: 1, alpha: 1)
        //let label = UILabel.init(frame: CGRect.init(x: 96.5 * self.ratioWidth, y: 16.5 * self.ratioHeight, width: (87.5+96) * self.ratioWidth, height: 23.5 * self.ratioHeight))
        let label = UILabel.init(frame: CGRect.init(x: 00, y: 0, width: buttonStart.frame.width, height: buttonStart.frame.height))
        label.text = "开始 Start"
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 20))
        label.textColor = UIColor.white
        buttonStart.addSubview(label)
        bottomView.addSubview(buttonStart)
        self.view.addSubview(bottomView)
        
        buttonStart.addTarget(self, action: #selector(tapStarting), for: UIControlEvents.touchUpInside)
    }
    
    func reImageSize(image: UIImage, width: CGFloat, height: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(CGSize.init(width: width, height: height))
        image.draw(in: CGRect.init(x: 0, y: 0, width: width, height: height))
        let reImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        return reImage
    }
    // picker view cols
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    // picker view lines
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 2
        } else if component == 1 {
            return 12
        } else {
            return 60
        }
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 48 * self.ratioHeight
    }
    // set each row's view
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel.init()
        if component == 0 {
            if row == 0 {
                label.text = "AM"
            } else {
                label.text = "PM"
            }
        } else if component == 1 {
            label.text = String(row)
        } else {
            if row < 10 {
                label.text = "0" + String(row)
            } else {
                label.text = String(row)
            }
        }
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 23))
        label.textAlignment = NSTextAlignment.center
        return label
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            self.time_range = (row == 0) ? "AM" : "PM"
        }
        if component == 1 { //hour
            self.clock_hour = row
        }
        if component == 2 {
            self.clock_minute = row
        }
    }
    
    /* monitor button setting */
    @objc func tapSetting() {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "setting") as UIViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func tapStarting() {
        let vc = AddClock.init()
        
        /* test */
        let alarm = Alarm.init()
        let now = NSDate()
        let timeNow = now.timeIntervalSince1970
        let dateform = DateFormatter.init()
        //dateform.timeZone = TimeZone.init(identifier: "UTC")
        dateform.dateFormat = "yyyy年MM月dd日"// HH:mm"
        let dateformSet = DateFormatter.init()
        //dateformSet.timeZone = TimeZone.init(identifier: "UTC")
        dateformSet.dateFormat = "yyyy年MM月dd日 HH:mm"
        //dateformSet.timeZone = TimeZone.init(secondsFromGMT: 8 * 3600)
        let dateNowString = dateform.string(from: now as Date)
        let dateStringSet = dateNowString + " \(self.clock_hour + (self.time_range == "AM" ? 0 : 12)):\(self.clock_minute)"
        var dateSet = dateformSet.date(from: dateStringSet)
        let timeSet = dateSet?.timeIntervalSince1970
        //dateSet = dateSet?.addingTimeInterval(8*3600)
        let weekdaySet = (Int(timeSet! / 86400) + 4) % 7 // 0 - 周一 6 - 周日
        self.remainTime = (timeSet! - timeNow) / 3600 //hour
        let dateformMonth = DateFormatter.init()
        let dateformDay = DateFormatter.init()
        //dateformMonth.timeZone = TimeZone.init(identifier: "UTC")
        //dateformDay.timeZone = TimeZone.init(identifier: "UTC")
        dateformMonth.dateFormat = "MM"
        dateformDay.dateFormat = "dd"
        let month = Int(dateformMonth.string(from: dateSet!))
        let day = Int(dateformDay.string(from: dateSet!))
        alarm.alarmDate = dateSet
        alarm.turnOnAlarm()
        /* store alarm info into file */
        let alarmInfoPath = StoreFileManager.getStoragePath(suffix: "/EmoClock/AlarmInfo/")
        let alramInfoFilePath = alarmInfoPath + "info.txt"
        print("store path: \(alarmInfoPath)")
        StoreFileManager.clearDirectory(path: alramInfoFilePath)
        let alarmInfo: Dictionary<String, Any> = ["alarmHour": self.clock_hour, "alarmMinute": self.clock_minute, "alarmMonth": month, "alarmDay": day, "alarmWeek": weekdaySet, "musicIndex": 1, "musicName": "Ed Sheeran - the Shape of you", "musicExtension": "m4a", "alarm_range": self.time_range, "time_remain": self.remainTime]
        var alarmInfoArray: Array<Dictionary<String, Any>> = []
        alarmInfoArray.append(alarmInfo)
        StoreFileManager.storeFileToPath(path: alramInfoFilePath, info: NSArray.init(array: alarmInfoArray))
        /* jump to AddClock viewcontroller */
        vc.clock_hour = self.clock_hour
        vc.clock_minute = self.clock_minute
        vc.time_range = self.time_range
        vc.remainTime = self.remainTime
        vc.weekday = weekdaySet
        vc.clock_month = month!
        vc.clock_day = day!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func tapStatistics() {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "Statistics") as UIViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
