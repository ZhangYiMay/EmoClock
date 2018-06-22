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
import UserNotifications

class MainPage: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UNUserNotificationCenterDelegate, UIAlertViewDelegate {
    
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
    var today: Bool = true
    /* iphone6 frame width and height*/
    let IPHONE6_WIDTH: CGFloat = 375.0
    let IPHONE6_HEIGHT: CGFloat = 667.0
    /* platform */
    let platform = UIDevice.current.modelName
    
    var flag = true //如果是打开app就自动跳到这个页面，则flag=true，如果是从主页跳过来，这个flag为false
    
    let center = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("MainPage: viewDidLoad")
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.isHidden = true
        if flag {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        } else {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
        
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
        
        /* set the background of the picker view */
        setPickerStyle()
        
        /* set the bottom view */
        setBottomView()
        
        let first: Bool = UserDefaults.standard.bool(forKey: "firstLauched")
        if first && flag {
            /* open the notification reminder */
            turnOnNotificationReminder()
            /* record first launched time */
            recordFirstLaunched()
            /* alert self test */
            alertSelfTest()
        }
        //alertSelfTest()
    }
    
    func alertSelfTest() {
        let alert = UIAlertController.init(title: "起床心情自测", message: "Hi，初次相识，几个小问题，帮助更好的了解你适合什么样的起床铃声哦 ：）", preferredStyle: UIAlertControllerStyle.alert)
        let rect = CGRect.init(x: 0 * self.ratioWidth, y: 0 * self.ratioHeight, width: 300 * self.ratioWidth, height: 324.5 * self.ratioHeight)
        let view = UIView.init(frame: rect)
        //alert.view = view
        let action = UIAlertAction.init(title: "开始测试", style: .default, handler: {(action)->Void in
            (self.navigationController?.pushViewController(SelfTest1(), animated: true))!
        })
        alert.addAction(action)
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func turnOnNotificationReminder() {
        // 注册Notification
        center.requestAuthorization(options: [UNAuthorizationOptions.sound, .alert], completionHandler: {(aBool, aError) in
            if aError == nil {
                print("no errors in request notification authorizations")
            }else {
                print("errors in request notification authorizations: \(aError.debugDescription)")
            }
        })
        center.getNotificationSettings(completionHandler: {(notification) in
            if notification.authorizationStatus == UNAuthorizationStatus.authorized {
                print("已同意通知")
            } else if notification.authorizationStatus == UNAuthorizationStatus.notDetermined {
                print("不确定")
            } else if notification.authorizationStatus == UNAuthorizationStatus.denied {
                print("已拒绝通知")
            }
        })
        center.delegate = self
    }
    
    func recordFirstLaunched() {
        let now = NSDate()
        let timeNow = now.timeIntervalSince1970
        let path = StoreFileManager.getStoragePath(suffix: "/EmoClock/FirstUse/")
        let filePath = path + "date.txt"
        let dateArr = [timeNow]
        StoreFileManager.storeFileToPath(path: filePath, info: NSArray.init(array: dateArr))
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
            let btnLeft = UIButton.init(frame: CGRect.init(x: 15, y: 56, width: 47 * self.ratioWidth, height: 21 * self.ratioHeight))
            //let btnLeft = UIButton.init(frame: CGRect.init(x: 15 * self.ratioWidth, y: 32 * self.ratioHeight, width: 30 * self.ratioWidth, height: 30 * self.ratioHeight)) //test
            btnLeft.setImage(itemImageLeft, for: UIControlState.normal)
            barView.addSubview(btnLeft)
            btnLeft.addTarget(self, action: #selector(tapback), for: .touchUpInside)
            
//            let itemImageRight = UIImage.init(named: "set")
//            let btnRight = UIButton.init(frame: CGRect.init(x: 333, y: 51, width: 27, height: 27))
//            btnRight.setImage(itemImageRight, for: UIControlState.normal)
//            barView.addSubview(btnRight)
//            btnRight.addTarget(self, action: #selector(tapSetting), for: UIControlEvents.touchUpInside)
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
            let btnLeft = UIButton.init(frame: CGRect.init(x: 15 * self.ratioWidth, y: 32 * self.ratioHeight, width: 47 * self.ratioWidth, height: 21 * self.ratioHeight))
            //let btnLeft = UIButton.init(frame: CGRect.init(x: 15 * self.ratioWidth, y: 32 * self.ratioHeight, width: 30 * self.ratioWidth, height: 30 * self.ratioHeight)) //test
            btnLeft.setImage(itemImageLeft, for: UIControlState.normal)
            barView.addSubview(btnLeft)
            btnLeft.addTarget(self, action: #selector(tapback), for: .touchUpInside)
            
//            let itemImageRight = UIImage.init(named: "set")
//            let btnRight = UIButton.init(frame: CGRect.init(x: 335 * self.ratioWidth, y: 28 * self.ratioHeight, width: 28 * self.ratioWidth, height: 28 * self.ratioHeight))
//            btnRight.setImage(itemImageRight, for: UIControlState.normal)
//            barView.addSubview(btnRight)
//            btnRight.addTarget(self, action: #selector(tapSetting), for: UIControlEvents.touchUpInside)
            self.view.addSubview(barView)
        }
    }
    
    func setPickerStyle() {
        var pickerBackView = UIView.init()
        if platform == "iPhone X" || (frameWidth == 375.0 && frameHeight == 812.0)
        {
            pickerBackView = UIView.init(frame: CGRect.init(x: 0, y: 89.5 * self.ratioHeight, width: self.frameWidth, height: self.frameHeight - 65.0 * self.ratioHeight))
        }
        else
        {
            pickerBackView = UIView.init(frame: CGRect.init(x: 0, y: 65.0 * self.ratioHeight, width: self.frameWidth, height: self.frameHeight - 65.0 * self.ratioHeight))
        }
        
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
        buttonStart.setTitle("开始 Start", for: .normal)
        buttonStart.setTitleColor(UIColor.white, for: .normal)
        buttonStart.setTitleColor(UIColor.gray, for: .highlighted)
        buttonStart.titleLabel?.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 20))
        //let label = UILabel.init(frame: CGRect.init(x: 96.5 * self.ratioWidth, y: 16.5 * self.ratioHeight, width: (87.5+96) * self.ratioWidth, height: 23.5 * self.ratioHeight))
//        let label = UILabel.init(frame: CGRect.init(x: 00, y: 0, width: buttonStart.frame.width, height: buttonStart.frame.height))
//        label.text = "开始 Start"
//        label.textAlignment = NSTextAlignment.center
//        label.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 20))
//        label.textColor = UIColor.white
//        buttonStart.addSubview(label)
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
        
        
        /* 获得当前的年月日 */
        let now = NSDate()
        let timeNow = now.timeIntervalSince1970
        let dateform = DateFormatter.init()
        dateform.dateFormat = "yyyy年MM月dd日"// HH:mm"
        let dateNowString = dateform.string(from: now as Date)
        /* 获得设置闹钟的年月日时分 */
        let dateformSet = DateFormatter.init()
        dateformSet.dateFormat = "yyyy年MM月dd日 HH:mm"
        let dateStringSet = dateNowString + " \(self.clock_hour + (self.time_range == "AM" ? 0 : 12)):\(self.clock_minute)"
        var dateSet = dateformSet.date(from: dateStringSet)
        /* 如果当前时间是晚上8-12点 则定的是第二天闹钟 否则定当天的 */
        let hourformDay = DateFormatter.init()
        hourformDay.dateFormat = "HH"
        let hour = Int(hourformDay.string(from: now as Date))
        if hour! >= 20 && hour! <= 24 {
            self.today = false
            dateSet = dateSet?.addingTimeInterval(24 * 3600) //明天
            setAndStoreAlarm(dateSet: dateSet, timeNow: timeNow)
        } else {
            self.today = true
            if timeNow > (dateSet?.timeIntervalSince1970)! { //设置非法闹钟
                let alert = UIAlertController.init(title: "不能设置早于当前时刻的闹钟哦～", message: "每天晚上8:00到11:59设置的是第二天的闹钟，其余时间设置的都是当天闹钟", preferredStyle: .alert)
                let action = UIAlertAction.init(title: "好的", style: .cancel, handler: nil)
                alert.addAction(action)
                self.navigationController?.present(alert, animated: true, completion: nil)
            } else {
                setAndStoreAlarm(dateSet: dateSet, timeNow: timeNow)
            }
        }
        
    }
    
    func setAndStoreAlarm(dateSet: Date!, timeNow: TimeInterval) {
        let alarm = Alarm.init()
        let timeSet = dateSet?.timeIntervalSince1970
        /* 获取星期和剩余时间 */
        let calendar = NSCalendar.init(identifier: .chinese)
        let zone = NSTimeZone.init(name: "Asia/Shanghai")
        calendar?.timeZone = zone as! TimeZone
        let weekdaySet = calendar?.component(.weekday, from: dateSet!) //1-周日 2-周一 7-周六
        //let weekdaySet = (Int(timeSet! / 86400) + 4) % 7 // 0 - 周一 6 - 周日
        self.remainTime = (timeSet! - timeNow) / 3600 //hour
        /* 分别获得设置闹钟的 年/月/日 */
        let dateformYear = DateFormatter.init()
        let dateformMonth = DateFormatter.init()
        let dateformDay = DateFormatter.init()
        dateformYear.dateFormat = "yyyy"
        dateformMonth.dateFormat = "MM"
        dateformDay.dateFormat = "dd"
        let year = Int(dateformYear.string(from: dateSet!))
        let month = Int(dateformMonth.string(from: dateSet!))
        let day = Int(dateformDay.string(from: dateSet!))
        /* 设置闹钟 */
        let music = MusicChose().getMusic()
        alarm.musicName = music + ".m4a"
        alarm.alarmDate = dateSet
        alarm.turnOnAlarm()
        /* 将信息存在本地文件 */
        // 闹钟基本信息
        let alarmInfoPath = StoreFileManager.getStoragePath(suffix: "/EmoClock/AlarmInfo/")
        let alramInfoFilePath = alarmInfoPath + "info.txt"
        print("store path: \(alarmInfoPath)")
        StoreFileManager.clearDirectory(path: alramInfoFilePath)
        let alarmInfo: Dictionary<String, Any> = ["alarmHour": self.clock_hour, "alarmMinute": self.clock_minute, "alarmMonth": month, "alarmDay": day, "alarmWeek": weekdaySet, "musicIndex": music, "musicName": music, "musicExtension": "m4a", "alarm_range": self.time_range, "time_remain": self.remainTime, "alarmYear": year, "dateSet": dateSet, "today" : self.today]
        var alarmInfoArray: Array<Dictionary<String, Any>> = []
        alarmInfoArray.append(alarmInfo)
        StoreFileManager.storeFileToPath(path: alramInfoFilePath, info: NSArray.init(array: alarmInfoArray))
        // 平均睡眠时间
        let sleepingPath = StoreFileManager.getStoragePath(suffix: "/EmoClock/SleepTime/")
        let sleepingFile = sleepingPath + "average.txt"
        var content = StoreFileManager.readFileAtPath(path: sleepingFile) as! Array<Dictionary<String, Any>>
        var pastTotal: Double = 0.0
        var pastCount: Int = 0
        if !content.isEmpty {
            pastTotal = content[0]["total"] as! Double
            pastCount = content[0]["count"] as! Int
        }
        pastTotal += self.remainTime
        pastCount += 1
        content = [["total": pastTotal, "count": pastCount, "recent": self.remainTime]]
        StoreFileManager.storeFileToPath(path: sleepingFile, info: NSArray.init(array: content))
        
        /* jump to AddClock viewcontroller */
        let vc = AddClock.init()
        vc.clock_hour = self.clock_hour
        vc.clock_minute = self.clock_minute
        vc.time_range = self.time_range
        vc.remainTime = self.remainTime
        vc.weekday = weekdaySet!
        vc.clock_month = month!
        vc.clock_day = day!
        vc.today = self.today
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tapback() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //print("MainPage: viewWillAppear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
