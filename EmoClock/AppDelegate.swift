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
        // 确定初始页面
        let initialViewIdentifier = "MainPage"
        let vc = sb.instantiateViewController(withIdentifier: initialViewIdentifier)
        let navigationController = UINavigationController(rootViewController: vc)
        self.window?.rootViewController=navigationController
        initialViewController()
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
        
        //判断是否是第一次启动app
        let everLauched = UserDefaults.standard.bool(forKey: "everLauched")
        if everLauched == false {
            UserDefaults.standard.set(true, forKey: "firstLauched")
            UserDefaults.standard.set(true, forKey: "everLauched")
        }else {
            UserDefaults.standard.set(false, forKey: "firstLauched")
        }
        
        return true
    }
    
    func initialViewController() {
        let path = StoreFileManager.getStoragePath(suffix: "/EmoClock/AlarmInfo/")
        let filePath = path + "info.txt"
        let content = NSArray.init(contentsOf: URL.init(string: "file://"+filePath)!)
        print(filePath)
        if content != nil { //having a clock
            //let vc = sb.instantiateViewController(withIdentifier: "AddClock")
            let alarmInfo = content![0] as! Dictionary<String, Any>
            let ad = AddClock()
            ad.time_range = alarmInfo["alarm_range"] as! String
            ad.clock_hour = alarmInfo["alarmHour"] as! Int
            ad.clock_minute = alarmInfo["alarmMinute"] as! Int
            ad.clock_month = alarmInfo["alarmMonth"] as! Int
            ad.clock_day = alarmInfo["alarmDay"] as! Int
            ad.weekday = alarmInfo["alarmWeek"] as! Int
            ad.remainTime = alarmInfo["time_remain"] as! Double
            ad.init_flag = true
            let navigationController = UINavigationController(rootViewController: ad)
            self.window?.rootViewController=navigationController
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "Ringing")
        self.window?.rootViewController = UINavigationController.init(rootViewController: vc)
        print("didReceive response")
        completionHandler()
    }
    
    
     func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willPresent notification")
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
        //initialViewController()
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        initialViewController()
        print("willFinishLaunchingWithOptions")
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

