//
//  Alarm.swift
//  EmoClock
//
//  Created by 李博闻 on 2018/3/7.
//  Copyright © 2018年 艺林. All rights reserved.
//  闹钟类

import UIKit
import UserNotifications

class Alarm: NSObject, NSCoding {
    
    var alarmDate: Date?
    var selectedDay: Int? = 0
    var alarmOn: Bool?
    
    var musicName = "7.m4a"//K组初始化
    let lastTime = 300 //seconds
    let lastInterval = 30 //seconds
    
    override init() {
        super.init()
    }
    
    func encode(with aCoder: NSCoder) { //序列化数据，把数据读到aCoder中
        aCoder.encode(self.alarmDate, forKey: "alarmDate")
        aCoder.encode(self.selectedDay, forKey: "selectedDay")
        aCoder.encode(self.alarmOn, forKey: "alarmOn")
    }
    
    required init?(coder aDecoder: NSCoder) { //反序列化数据，把数据从aCoder读到相应变量中
        alarmDate = aDecoder.decodeObject(forKey: "alarmDate") as! Date
        selectedDay = aDecoder.decodeObject(forKey: "selectedDay") as! Int
        alarmOn = aDecoder.decodeObject(forKey: "alarmOn") as! Bool
    }
    
    func turnOnAlarm() {
        self.addLocalNotificationForDate()
    }
    
    func turnOffAlarm() {
        
    }
}

extension Alarm {
    fileprivate func addLocalNotificationForDate() {
        print("开始创建闹钟通知")
        // 创建通知内容
        let content = UNMutableNotificationContent.init()
        content.title = "EmoClock"
        content.body = "要进入EmoClock才能关闭闹钟哟～"
        content.sound = UNNotificationSound.init(named: musicName)
        content.categoryIdentifier = "myNotificationCategory"
        // 创建触发机制
        let calendar = Calendar.current
        let type: NSCalendar.Unit = [NSCalendar.Unit.year, .month, .day, .hour, .minute, .second]
        let dateComponents = (calendar as NSCalendar).components(type, from: self.alarmDate!)
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: dateComponents, repeats: false)
        //let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 0.5, repeats: true)
        
        // 发送请求标识符
        let identifier = "alarm"
        // 创建一个发送请求
        let request = UNNotificationRequest.init(identifier: identifier, content: content, trigger: trigger)
        // 将request添加到发送中心
        UNUserNotificationCenter.current().add(request, withCompletionHandler:{(error) in
            if error == nil {
                //print("no error in adding notifications")
            }else {
                print(error.debugDescription)
            }
        })
        // 附加request- 解决不重复闹铃的问题
        let repeatTime: Int = self.lastTime / self.lastInterval
        var tempDate = self.alarmDate
        for var i in 1...repeatTime {
            let identifier_add = "alarm" + String(i)
            let content_add = UNMutableNotificationContent.init()
            content_add.title = "EmoClock"
            content_add.body = "要进入EmoClock才能关闭闹钟哟～"
            content_add.sound = UNNotificationSound.init(named: musicName)
            content_add.categoryIdentifier = "myNotificationCategory"
            
            var addAlarmDate = tempDate?.addingTimeInterval(30)
            let dateComponents_add = (calendar as NSCalendar).components(type, from: addAlarmDate!)
            let trigger_add = UNCalendarNotificationTrigger.init(dateMatching: dateComponents_add, repeats: false)
            let request_add = UNNotificationRequest.init(identifier: identifier_add, content: content_add, trigger: trigger_add)
            UNUserNotificationCenter.current().add(request_add, withCompletionHandler:{(error) in
                if error == nil {
                    //print("no error in adding notifications")
                }else {
                    print(error.debugDescription)
                }
            })
            tempDate = addAlarmDate
        }
    }
}
