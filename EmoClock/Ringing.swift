//
//  Ringing.swift
//  EmoClock
//
//  Created by 李博闻 on 2018/3/5.
//  Copyright © 2018年 艺林. All rights reserved.
//

import UIKit
import AVFoundation
import UserNotifications

class Ringing: UIViewController {
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
    /* music name and extension */
    var musicIndex = "7" //K组初始化
    var musicName = "7" //K组初始化
    let musicExt = "m4a"
    /* alarm infomation to display */
    var alarm_hour = 0
    var alarm_minute = 0
    var alarm_month = 0
    var alarm_day = 0
    var alarm_week = 0
    var alarm_range = "AM"
    var remain_time: Double = 0.0
    let weekCh = ["一", "二", "三", "四", "五", "六", "日"]
    /* alarm date format */
    var dateSet: Date?
    
    
    /* music */
    var player: AVAudioPlayer = AVAudioPlayer.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.isNavigationBarHidden = true
        /* read alarm info from file */
        readAlarmInfoFromFile()
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
        self.view.backgroundColor = self.backColor
        // label: show clock time
        //let label_time = UILabel.init(frame: CGRect.init(x: 134*self.ratioWidth, y: 91*self.ratioHeight, width: 107.5*self.ratioWidth, height: 52*self.ratioHeight))
        let label_time = UILabel.init(frame: CGRect.init(x: 0, y: 91*self.ratioHeight, width: self.frameWidth, height: 52*self.ratioHeight))
        label_time.textAlignment = .center
        label_time.text = String(self.alarm_hour) + ":" + (self.alarm_minute < 10 ? "0"+String(self.alarm_minute) : String(self.alarm_minute))
        label_time.textColor = UIColor.white
        label_time.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 50))
        self.view.addSubview(label_time)
        // label: date
        //let label_date = UILabel.init(frame: CGRect.init(x: 136.5*self.ratioWidth, y: 150.5*self.ratioHeight, width: 102*self.ratioWidth, height: 15.5*self.ratioHeight))
        let label_date = UILabel.init(frame: CGRect.init(x: 0, y: 150.5*self.ratioHeight, width: self.frameWidth, height: 15.5*self.ratioHeight))
        label_date.textAlignment = .center
        //label_date.text = "11.25日 星期五"
        label_date.text = (self.alarm_month < 10 ? "0" + String(self.alarm_month) : String(self.alarm_month)) + "." + (self.alarm_day < 10 ? "0" + String(self.alarm_day) : String(self.alarm_day)) + "日 星期" + weekCh[self.alarm_week]
        label_date.textColor = UIColor.white
        label_date.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
        self.view.addSubview(label_date)
        // label: name
        //let label_name = UILabel.init(frame: CGRect.init(x: 165.5*self.ratioWidth, y: 231.5*self.ratioHeight, width: 45*self.ratioWidth, height: 23*self.ratioHeight))
        let label_name = UILabel.init(frame: CGRect.init(x: 0, y: 231.5*self.ratioHeight, width: self.frameWidth, height: 23*self.ratioHeight))
        label_name.textAlignment = .center
        label_name.text = "闹钟"
        label_name.textColor = UIColor.white
        label_name.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 22))
        self.view.addSubview(label_name)
        // label: english
        let label_eng = UILabel.init(frame: CGRect.init(x: 80*self.ratioWidth, y: 264.5*self.ratioHeight, width: 216.5*self.ratioWidth, height: 15.5*self.ratioHeight))
        //label_eng.text = "Ed Sheeran - the Shape of you"
        label_eng.textAlignment = .center
        label_eng.text = self.musicName
        label_eng.textColor = UIColor.white
        label_eng.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
        self.view.addSubview(label_eng)
        // button cancel
        let btnRect = CGRect.init(x: 46.5 * self.ratioWidth, y: 371.5*self.ratioHeight, width: 280 * self.ratioWidth, height: 57 * self.ratioHeight)
        let buttonCancel = UIButton.init(frame: btnRect)
        buttonCancel.layer.masksToBounds = true
        buttonCancel.layer.cornerRadius = 30 * self.ratioWidth
        buttonCancel.backgroundColor = UIColor.init(red: 50/255, green: 136/255, blue: 1, alpha: 1)
        //let label = UILabel.init(frame: CGRect.init(x: 70.5 * self.ratioWidth, y: 15 * self.ratioHeight, width: 139 * self.ratioWidth, height: 28 * self.ratioHeight))
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 15 * self.ratioHeight, width: buttonCancel.frame.width, height: 28 * self.ratioHeight))
        label.textAlignment = .center
        label.text = "稍后提醒 Later"
        label.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 20))
        label.textColor = UIColor.white
        buttonCancel.addSubview(label)
        buttonCancel.addTarget(self, action: #selector(delayAlarm), for: .touchUpInside)
        self.view.addSubview(buttonCancel)
        //buttonStart.addTarget(self, action: #selector(tapStarting), for: UIControlEvents.touchUpInside)
        //button close
        let view = UIView.init(frame: CGRect.init(x: 115*self.ratioWidth, y: 531*self.ratioHeight, width: 145.5*self.ratioWidth, height: 57.5*self.ratioHeight))
        view.backgroundColor = UIColor.init(red: 50/255, green: 136/255, blue: 1, alpha: 1)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 30 * self.ratioWidth
        let buttonClose = UIButton.init(frame: CGRect.init(x: 1*self.ratioWidth, y: 1*self.ratioHeight, width: 143.5*self.ratioWidth, height: 55.5*self.ratioHeight))
        buttonClose.backgroundColor = self.backColor
        buttonClose.layer.masksToBounds = true
        buttonClose.layer.cornerRadius = 30 * self.ratioWidth
        view.addSubview(buttonClose)
        //let labelClose = UILabel.init(frame: CGRect.init(x: 21.5*self.ratioWidth, y: 19*self.ratioHeight, width: 102*self.ratioWidth, height: 21*self.ratioHeight))
        let labelClose = UILabel.init(frame: CGRect.init(x: 0, y: 19*self.ratioHeight, width: buttonClose.frame.width, height: 21*self.ratioHeight))
        labelClose.textAlignment = .center
        labelClose.textColor = UIColor.init(red: 0.1961, green: 0.5333, blue: 1, alpha: 1)
        labelClose.text = "关闭 Close"
        labelClose.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 20))
        
        view.addSubview(labelClose)
        self.view.addSubview(view)
        buttonClose.addTarget(self, action: #selector(closeAllClocks), for: UIControlEvents.touchUpInside)
        
        // continue playing music
        let url = Bundle.main.url(forResource: musicName, withExtension: musicExt)
        do {
            self.player = try AVAudioPlayer.init(contentsOf: url!)
        } catch let error as NSError {
            print("music player error: \(error)")
        }
        self.player.prepareToPlay()
        self.player.play()
    }
    
    @objc func delayAlarm() {
        //print("delay alarm")
        self.player.stop()
        /* delete all the notifications*/
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        center.removeAllDeliveredNotifications()
        /* remove files */
        let path = StoreFileManager.getStoragePath(suffix: "/EmoClock/AlarmInfo/")
        StoreFileManager.clearDirectory(path: path + "info.txt")
        /* 设置新的闹钟 */
        var newMin = self.alarm_minute + 10
        var newHour = self.alarm_hour
        if newMin >= 60 {
            newMin -= 60
            newHour = newHour + 1
        }
        let newDateSet = self.dateSet?.addingTimeInterval(600) //10min
        /* 设置闹钟 */
        let alarm = Alarm()
        let music = MusicChose().getMusic()
        alarm.musicName = music + ".m4a"
        alarm.alarmDate = newDateSet
        alarm.turnOnAlarm()
        /* 将信息存在本地文件 */
        // 闹钟基本信息
        /* 分别获得设置闹钟的 年/月/日 */
        let dateformYear = DateFormatter.init()
        let dateformMonth = DateFormatter.init()
        let dateformDay = DateFormatter.init()
        dateformYear.dateFormat = "yyyy"
        dateformMonth.dateFormat = "MM"
        dateformDay.dateFormat = "dd"
        let year = Int(dateformYear.string(from: newDateSet!))
        let month = Int(dateformMonth.string(from: newDateSet!))
        let day = Int(dateformDay.string(from: newDateSet!))
        /* 获取星期和剩余时间 */
        let calendar = NSCalendar.init(identifier: .chinese)
        let zone = NSTimeZone.init(name: "Asia/Shanghai")
        calendar?.timeZone = zone as! TimeZone
        let weekdaySet = calendar?.component(.weekday, from: newDateSet!)
        /* 存储 */
        let alarmInfoPath = StoreFileManager.getStoragePath(suffix: "/EmoClock/AlarmInfo/")
        let alramInfoFilePath = alarmInfoPath + "info.txt"
        print("store path: \(alarmInfoPath)")
        StoreFileManager.clearDirectory(path: alramInfoFilePath)
        let alarmInfo: Dictionary<String, Any> = ["alarmHour": newHour, "alarmMinute": newMin, "alarmMonth": month, "alarmDay": day, "alarmWeek": weekdaySet, "musicIndex": music, "musicName": music, "musicExtension": "m4a", "alarm_range": self.alarm_range, "time_remain": self.remain_time, "alarmYear": year, "dateSet": newDateSet]
        var alarmInfoArray: Array<Dictionary<String, Any>> = []
        alarmInfoArray.append(alarmInfo)
        StoreFileManager.storeFileToPath(path: alramInfoFilePath, info: NSArray.init(array: alarmInfoArray))
        /* 页面跳转 */
        let ad = AddClock()
        ad.clockDate = newDateSet
        ad.clock_month = month!
        ad.clock_day = day!
        ad.clock_hour = newHour
        ad.clock_minute = newMin
        ad.weekday = weekdaySet!
        ad.time_range = self.alarm_range
        ad.remainTime = self.remain_time
        ad.init_flag = true
        self.navigationController?.pushViewController(ad, animated: true)
    }
    
    @objc func closeAllClocks() {
        //print("closeAllClocks...")
        self.player.stop()
        /* delete all the notifications*/
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        center.removeAllDeliveredNotifications()
        /* remove files */
        let path = StoreFileManager.getStoragePath(suffix: "/EmoClock/AlarmInfo/")
        StoreFileManager.clearDirectory(path: path + "info.txt")
        /* jump back to main page*/
        //let sb = UIStoryboard.init(name: "Main", bundle: nil)
        //let vc = sb.instantiateViewController(withIdentifier: "Feedback")
        let fd = Feedback()
        fd.alarm_hour = self.alarm_hour
        fd.alarm_minute = self.alarm_minute
        fd.alarm_month = self.alarm_month
        fd.alarm_day = self.alarm_day
        //fd.alarm_music = self.alarm_music
        self.navigationController?.pushViewController(fd, animated: true)
    }
    
    func readAlarmInfoFromFile() {
        let path = StoreFileManager.getStoragePath(suffix: "/EmoClock/AlarmInfo/info.txt")
        let alarmInfoArr = StoreFileManager.readFileAtPath(path: path) as! Array<Dictionary<String, Any>>
        if alarmInfoArr != nil {
            let alarmInfo = alarmInfoArr[0]
            self.alarm_hour = alarmInfo["alarmHour"] as! Int
            self.alarm_minute = alarmInfo["alarmMinute"] as! Int
            self.alarm_month = alarmInfo["alarmMonth"] as! Int
            self.alarm_day = alarmInfo["alarmDay"] as! Int
            self.alarm_week = alarmInfo["alarmWeek"] as! Int
            self.musicName = alarmInfo["musicName"] as! String
            self.musicIndex = alarmInfo["musicIndex"] as! String
            self.dateSet = alarmInfo["dateSet"] as! Date?
            self.remain_time = alarmInfo["time_remain"] as! Double
            self.alarm_range = alarmInfo["alarm_range"] as! String
            //print(alarmInfo)
        }
        
    }
    
    func setBottomView() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
