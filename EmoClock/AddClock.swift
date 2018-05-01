//
//  AddClock.swift
//  EmoClock
//
//  Created by 李博闻 on 2018/3/5.
//  Copyright © 2018年 艺林. All rights reserved.
//

import UIKit
import UserNotifications

class AddClock: UIViewController {
    
    /* global var: the size of the frame */
    var frameHeight: CGFloat = 0.0
    var frameWidth: CGFloat = 0.0
    /* global var: the ratio of the current frame */
    var ratioWidth: CGFloat = 0.0
    var ratioHeight: CGFloat = 0.0
    /* global color */
    let backColor = UIColor.init(red: 0.0, green: 33/255, blue: 49/255, alpha: 1.0)
    /* transmit from other view */
    var clock_hour = 8
    var clock_minute = 0
    var clock_month = 0
    var clock_day = 0
    var time_range = "AM"
    var clockDate: Date?
    var remainTime: Double = 0.0
    var weekday: Int = 0
    let week = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
    /* iphone6 frame width and height*/
    let IPHONE6_WIDTH: CGFloat = 375.0
    let IPHONE6_HEIGHT: CGFloat = 667.0
    /* storyboard */
    let sb = UIStoryboard.init(name: "Main", bundle: nil)
    /* the flag indicates that whether the page come from initialize */
    var init_flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
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
        setClockView()
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
        btnLeft.addTarget(self, action: #selector(testFeed), for: UIControlEvents.touchUpInside)
        
        let itemImageRight = UIImage.init(named: "set")
        let btnRight = UIButton.init(frame: CGRect.init(x: 335 * self.ratioWidth, y: 28 * self.ratioHeight, width: 28 * self.ratioWidth, height: 28 * self.ratioHeight))
        btnRight.setImage(itemImageRight, for: UIControlState.normal)
        barView.addSubview(btnRight)
        btnRight.addTarget(self, action: #selector(testRing), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(barView)
    }
    @objc func testRing() {
        
        let vc = sb.instantiateViewController(withIdentifier: "Ringing") as UIViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func testFeed() {
        let vc = sb.instantiateViewController(withIdentifier: "Feedback") as UIViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setClockView() {
        let remainView = UIView.init(frame: CGRect.init(x: 0, y: 65.0 * self.ratioHeight, width: self.frameWidth, height: self.frameHeight - 65.0 * self.ratioHeight))
        remainView.backgroundColor = self.backColor
        // imgView
        let imView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.frameWidth, height: 446 * self.ratioHeight))
        imView.image = UIImage.init(named: "background")
        remainView.addSubview(imView)
        // label AM
        let label_am = UILabel.init(frame: CGRect.init(x: 115 * self.ratioWidth, y: 171 * self.ratioHeight, width: 44 * self.ratioWidth, height: 28.5 * self.ratioHeight))
        label_am.text = self.time_range
        label_am.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 27))
        label_am.textColor = UIColor.white
        remainView.addSubview(label_am)
        // label time
        let label_clock = UILabel.init(frame: CGRect.init(x: 184 * self.ratioWidth, y: 163.5 * self.ratioHeight, width: (77.5+110) * self.ratioWidth, height: 37.5 * self.ratioHeight))
        if self.clock_minute < 10 {
            label_clock.text = String(self.clock_hour) + ":0" + String(self.clock_minute)
        } else {
            label_clock.text = String(self.clock_hour) + ":" + String(self.clock_minute)
        }
        label_clock.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 36))
        label_clock.textColor = UIColor.white
        remainView.addSubview(label_clock)
        // label date
        //let label_date = UILabel.init(frame: CGRect.init(x: 118.5 * self.ratioWidth, y: 208 * self.ratioHeight, width: (138+110) * self.ratioWidth, height: 15.5 * self.ratioHeight))
        let label_date = UILabel.init(frame: CGRect.init(x: 0, y: 208 * self.ratioHeight, width: self.frameWidth, height: 15.5 * self.ratioHeight))
        let monthString = self.clock_month < 10 ? "0\(self.clock_month)" : "\(self.clock_month)"
        let dayString = self.clock_day < 10 ? "0\(self.clock_day)" : "\(self.clock_day)"
        label_date.text = monthString + "." + dayString + "日 " + "\(self.week[self.weekday]) " + "明天"
        label_date.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
        label_date.textAlignment = .center
        label_date.textColor = UIColor.white
        remainView.addSubview(label_date)
        // label remain sleeping time
        //let label_sleep = UILabel.init(frame: CGRect.init(x: 126.5 * self.ratioWidth, y: 266.5 * self.ratioHeight, width: (122.5+120) * self.ratioWidth, height: 15.5 * self.ratioHeight))
        let label_sleep = UILabel.init(frame: CGRect.init(x: 0, y: 266.5 * self.ratioHeight, width: self.frameWidth, height: 15.5 * self.ratioHeight))
        label_sleep.textAlignment = .center
        label_sleep.text = "今晚剩余睡眠时间"
        label_sleep.textColor = UIColor.white
        label_sleep.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
        remainView.addSubview(label_sleep)
        // label remain sleeping time - data
        //let label_sleepdata = UILabel.init(frame: CGRect.init(x: 164.5 * self.ratioWidth, y: 288.5 * self.ratioHeight, width: 46.5 * self.ratioWidth, height: 23 * self.ratioHeight))
        let label_sleepdata = UILabel.init(frame: CGRect.init(x: 0, y: 288.5 * self.ratioHeight, width: self.frameWidth, height: 23 * self.ratioHeight))
        label_sleepdata.text = String(format: "%.1f", self.remainTime) + "h"
        label_sleepdata.textAlignment = .center
        label_sleepdata.textColor = UIColor.white
        label_sleepdata.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 22))
        remainView.addSubview(label_sleepdata)
        // button cancel
        let btnCancel = UIButton.init(frame: CGRect.init(x: 168.5 * self.ratioWidth, y: 469.5 * self.ratioHeight, width: 38 * self.ratioWidth, height: 37 * self.ratioHeight))
        btnCancel.setImage(UIImage.init(named: "cancel"), for: .normal)
        remainView.addSubview(btnCancel)
        // 添加长按手势
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(pressCancel))
        print("**\(longPress.numberOfTouches)")
        btnCancel.addGestureRecognizer(longPress)
        // label cancel
        //let label_cancel = UILabel.init(frame: CGRect.init(x: 119.5 * self.ratioWidth, y: 526 * self.ratioHeight, width: 137 * self.ratioWidth, height: 25 * self.ratioHeight))
        let label_cancel = UILabel.init(frame: CGRect.init(x: 0, y: 526 * self.ratioHeight, width: self.frameWidth, height: 25 * self.ratioHeight))
        label_cancel.textAlignment = .center
        label_cancel.text = "取消闹钟 Cancel"
        label_cancel.textColor = UIColor.white
        label_cancel.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 18))
        remainView.addSubview(label_cancel)
        
        self.view.addSubview(remainView)
    }
    
    @objc func pressCancel(sender: UIGestureRecognizer) {
        if sender.state == .began {
            // 取消已有的所有通知
            let center = UNUserNotificationCenter.current()
            center.removeAllDeliveredNotifications() // has shown
            center.removeAllPendingNotificationRequests() // not shown yet
            // jump back
            if self.init_flag {
                let vc = sb.instantiateViewController(withIdentifier: "MainPage") as UIViewController
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
            /* clear file */
            let path = StoreFileManager.getStoragePath(suffix: "/EmoClock/AlarmInfo/")
            let filePath = path+"info.txt"
            StoreFileManager.clearDirectory(path: filePath)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
