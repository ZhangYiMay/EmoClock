//
//  AppDelegate.swift
//  EmoClock
//
//  Created by 李博闻 on 2018/3/3.
//  Copyright © 2018年 艺林. All rights reserved.
//

import UIKit
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    let center = UNUserNotificationCenter.current()
    let sb = UIStoryboard(name: "Main", bundle: nil)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("didFinishLaunchingWithOptions")
        self.center.delegate = self
        // 确定初始页面
        initialViewController()
        return true
    }
    
    func initialViewController() {
        print("initialViewController")
        //判断是否是第一次启动app
        let everLauched = UserDefaults.standard.bool(forKey: "everLauched")
        if everLauched == false {
            UserDefaults.standard.set(true, forKey: "firstLauched")
            UserDefaults.standard.set(true, forKey: "everLauched")
        }else {
            UserDefaults.standard.set(false, forKey: "firstLauched")
        }
        //引导页
        let first = UserDefaults.standard.bool(forKey: "firstLauched")
        if first {
            print("first luanched!!!")
            let guide = sb.instantiateViewController(withIdentifier: "GuideView")
            self.window?.rootViewController = UINavigationController.init(rootViewController: guide)
        } else { //不是第一次
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
                
                let dateform = DateFormatter.init()
                dateform.dateFormat = "yyyy年MM月dd日 HH:mm"// HH:mm"
                let dateString = "\(clockYear)年\(clockMonth)月\(clockDay)日 \(clock_range == "AM" ? clockHour : (clockHour + 12)):\(clockMin)"
                //let dateStringSet = dateNowString + " \(self.clock_hour + (self.time_range == "AM" ? 0 : 12)):\(self.clock_minute)"
                var dateSet = dateform.date(from: dateString)
                let timeSet = dateSet?.timeIntervalSince1970
                let now = NSDate().timeIntervalSince1970
                if timeSet! <= now { //已经响过闹铃了
                    //center.removeAllDeliveredNotifications()
                    //center.removeAllPendingNotificationRequests()
                    //let ring = Ringing()
                    let ring = sb.instantiateViewController(withIdentifier: "Ringing")
                    let navigationController = UINavigationController(rootViewController: ring)
                    self.window?.rootViewController=navigationController
                } else {
                    let sp = StartPage()
//                    sp.time_range = alarmInfo["alarm_range"] as! String
//                    sp.clock_hour = clockHour
//                    sp.clock_minute = clockMin
//                    sp.clock_month = clockMonth
//                    sp.clock_day = clockDay
//                    sp.weekday = alarmInfo["alarmWeek"] as! Int
//                    sp.remainTime = alarmInfo["time_remain"] as! Double
//                    sp.init_flag = true
//                    sp.today = today
                    let navigationController = UINavigationController(rootViewController: sp)
                    self.window?.rootViewController=navigationController
                }
            } else { //没有闹钟
                let vc = sb.instantiateViewController(withIdentifier: "MainPage")
                let navigationController = UINavigationController(rootViewController: vc)
                self.window?.rootViewController=navigationController
            }
        }
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let vc = sb.instantiateViewController(withIdentifier: "Ringing")
        self.window?.rootViewController = UINavigationController.init(rootViewController: vc)
        print("didReceive response")
        completionHandler()
    }
    
    
     func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willPresent notification")
        let vc = sb.instantiateViewController(withIdentifier: "Ringing")
        self.window?.rootViewController = UINavigationController.init(rootViewController: vc)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        print("applicationWillResignActive")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("applicationDidEnterBackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("applicationWillEnterForeground")
        initialViewController()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("applicationDidBecomeActive")
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        print("willFinishLaunchingWithOptions")
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

