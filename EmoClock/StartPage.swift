//
//  StartPage.swift
//  EmoClock
//
//  Created by 李博闻 on 2018/6/16.
//  Copyright © 2018年 艺林. All rights reserved.
//

import UIKit
import UserNotifications

class StartPage: UIViewController, UNUserNotificationCenterDelegate, UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    
    /* global var: the size of the frame */
    var frameHeight: CGFloat = 0.0
    var frameWidth: CGFloat = 0.0
    /* global var: the ratio of the scurrent frame */
    var ratioWidth: CGFloat = 0.0
    var ratioHeight: CGFloat = 0.0
    var backup: CGFloat = 0.0
    /* global color */
    let backColor = UIColor.init(red: 0.0, green: 33/255, blue: 49/255, alpha: 1.0)
    /* clock setting */
    var clock_hour: [Int] = []
    var clock_minute: [Int] = []
    var time_range: [String] = []
    var remainTime: [Double] = []
    var today: [Bool] = []
    var clock_month: [Int] = []
    var clock_day: [Int] = []
    var weekday: [Int] = []
    var init_flag = true
    /* iphone6 frame width and height*/
    let IPHONE6_WIDTH: CGFloat = 375.0
    let IPHONE6_HEIGHT: CGFloat = 667.0
    /* platform */
    let platform = UIDevice.current.modelName
    /* alarm number */
    var alarmNum = 0
    
    var flag = true
    
    let center = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("MainPage: viewDidLoad")
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
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
        /* read alarm info from files */
        readAlarmInfo()
        /* set ramain view */
        setRemainView()
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
            
            let itemImageLeft = UIImage.init(named: "statistics")
            let btnLeft = UIButton.init(frame: CGRect.init(x: 15, y: 55, width: 22, height: 20))
            //let btnLeft = UIButton.init(frame: CGRect.init(x: 15 * self.ratioWidth, y: 32 * self.ratioHeight, width: 30 * self.ratioWidth, height: 30 * self.ratioHeight)) //test
            btnLeft.setImage(itemImageLeft, for: UIControlState.normal)
            barView.addSubview(btnLeft)
            btnLeft.addTarget(self, action: #selector(tapSetting), for: .touchUpInside)
            
            let itemImageRight = UIImage.init(named: "add")
            let btnRight = UIButton.init(frame: CGRect.init(x: 333, y: 51, width: 22, height: 22))
            btnRight.setImage(itemImageRight, for: UIControlState.normal)
            barView.addSubview(btnRight)
            btnRight.addTarget(self, action: #selector(tapAdding), for: UIControlEvents.touchUpInside)
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
            
            let itemImageLeft = UIImage.init(named: "statistics")
            let btnLeft = UIButton.init(frame: CGRect.init(x: 15 * self.ratioWidth, y: 32 * self.ratioHeight, width: 23.5 * self.ratioWidth, height: 20 * self.ratioHeight))
            //let btnLeft = UIButton.init(frame: CGRect.init(x: 15 * self.ratioWidth, y: 32 * self.ratioHeight, width: 30 * self.ratioWidth, height: 30 * self.ratioHeight)) //test
            btnLeft.setImage(itemImageLeft, for: UIControlState.normal)
            barView.addSubview(btnLeft)
            btnLeft.addTarget(self, action: #selector(tapSetting), for: .touchUpInside)
            
            let itemImageRight = UIImage.init(named: "add")
            let btnRight = UIButton.init(frame: CGRect.init(x: 333 * self.ratioWidth, y: 28 * self.ratioHeight, width: 22 * self.ratioWidth, height: 22 * self.ratioHeight))
            btnRight.setImage(itemImageRight, for: UIControlState.normal)
            barView.addSubview(btnRight)
            btnRight.addTarget(self, action: #selector(tapAdding), for: UIControlEvents.touchUpInside)
            self.view.addSubview(barView)
        }
    }
    
    func readAlarmInfo() {
        //let alarmInfo: Dictionary<String, Any> = ["alarmHour": self.clock_hour, "alarmMinute": self.clock_minute, "alarmMonth": month, "alarmDay": day, "alarmWeek": weekdaySet, "musicIndex": music, "musicName": music, "musicExtension": "m4a", "alarm_range": self.time_range, "time_remain": self.remainTime, "alarmYear": year, "dateSet": dateSet, "today" : self.today]
        let path = StoreFileManager.getStoragePath(suffix: "/EmoClock/AlarmInfo/") + "info.txt"
        let content = StoreFileManager.readFileAtPath(path: path)
        if !content.isEmpty {
            self.alarmNum = content.count
            for i in 0..<self.alarmNum {
                let alarm = content[i] as! Dictionary<String, Any>
                self.clock_hour.append(alarm["alarmHour"] as! Int)
                self.clock_minute.append(alarm["alarmMinute"] as! Int)
                self.time_range.append(alarm["alarm_range" as String] as! String)
            }
        }
    }
    
    func setRemainView() {
        var remainView = UIView.init()
        if platform == "iPhone X" || (frameWidth == 375.0 && frameHeight == 812.0)
        {
            remainView = UIView.init(frame: CGRect.init(x: 0, y: 89.5 * self.ratioHeight, width: self.frameWidth, height: self.frameHeight - 65.0 * self.ratioHeight))
        }
        else
        {
            remainView = UIView.init(frame: CGRect.init(x: 0, y: 65.0 * self.ratioHeight, width: self.frameWidth, height: self.frameHeight - 65.0 * self.ratioHeight))
        }
        remainView.backgroundColor = self.backColor
        
        // Table view
        let tv = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: self.frameWidth, height: 547.5 * self.ratioHeight ))
        tv.backgroundColor = self.backColor
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView.init()
        remainView.addSubview(tv)
        self.view.addSubview(remainView)
        //label
        var height: CGFloat = 0
        if platform == "iPhone X" || (self.frameWidth.isEqual(to: 375.0) && self.frameHeight.isEqual(to: 812.0)) {
            height = frameHeight - 90 - 57
        } else {
            height = frameHeight - 65.5 - 57
        }
        let label = UILabel.init(frame: CGRect.init(x: 28 * self.ratioWidth, y: height * self.ratioHeight, width: 320 * self.ratioWidth, height: 26 * self.ratioHeight))
        label.text = "为了保证闹钟的正常运行，使用过程中请勿开启【勿扰模式】，请勿【静音】，如有需要，您可以使用飞行模式哦：）"
        label.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 9))
        label.textColor = UIColor.init(white: 1, alpha: 0.5)
        label.numberOfLines = 2
        label.textAlignment = .center
        remainView.addSubview(label)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.alarmNum
    }

    // cell的高度设定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94.5*self.ratioHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = StartPageCell.init(style: .default, reuseIdentifier: "cell", ratioWidth: self.ratioWidth, ratioHeight: self.ratioHeight, alarmRange: self.time_range[indexPath.row], alarmHour: self.clock_hour[indexPath.row], alarmMinute: self.clock_minute[indexPath.row])
        return cell
    }
    
    @objc func tapSetting() {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "setting") as UIViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tapAdding() {
        let mp = MainPage()
        mp.flag = false
        self.navigationController?.pushViewController(mp, animated: true)
    }
}
