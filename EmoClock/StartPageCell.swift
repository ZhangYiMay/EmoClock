//
//  StartPageCell.swift
//  EmoClock
//
//  Created by 李博闻 on 2018/6/16.
//  Copyright © 2018年 艺林. All rights reserved.
//

import UIKit

class StartPageCell: UITableViewCell {
    
    /* iphone6 frame width and height*/
    var ratioWidth: CGFloat = 0.0
    var ratioHeight: CGFloat = 0.0
    /* alarm info */
    var timeRange: String = "AM"
    var alarmHour = 0
    var alarmMinute = 0
    var alarmTurnOn: Bool = true
    var alarmPeriod: String = "每个工作日"
    
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, ratioWidth: CGFloat, ratioHeight: CGFloat, alarmRange: String, alarmHour: Int, alarmMinute: Int) {
        //super.init()
        self.ratioHeight = ratioHeight
        self.ratioWidth = ratioWidth
        self.timeRange = alarmRange
        self.alarmHour = alarmHour
        self.alarmMinute = alarmMinute
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)//super.init必须在子类所有未初始化的非Optional属性初始化之后调用。
        self.backgroundColor = UIColor.init(white: 0, alpha: 0)
        let sView = UIView.init(frame: self.frame)
        sView.backgroundColor = UIColor.init(red: 3/255, green: 37/255, blue: 58/255, alpha: 1)//03253a
        self.selectedBackgroundView = sView
        setUI()
    }
    
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setUI()
//    }
    
    func setUI() {
        // label for AM or PM
        let labelRange = UILabel(frame: CGRect(x: 16 * self.ratioWidth, y: 36 * self.ratioHeight, width: 35 * self.ratioWidth, height: 28 * self.ratioHeight))
        labelRange.text = self.timeRange
        labelRange.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 20))
        labelRange.textColor = UIColor.white
        self.addSubview(labelRange)
        // label for time
        let labelTime = UILabel(frame: CGRect(x: 54 * self.ratioWidth, y: (-4) * self.ratioHeight, width: 200 * self.ratioWidth, height: 84 * self.ratioHeight))
        labelTime.text = "\(self.alarmHour)" + (self.alarmMinute < 10 ? ":0\(self.alarmMinute)" : ":\(self.alarmMinute)")
        labelTime.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 60))
        labelTime.textColor = UIColor.white
        self.addSubview(labelTime)
        // label for period
        let labelPeriod = UILabel(frame: CGRect(x: 16 * self.ratioWidth, y: 62 * self.ratioHeight, width: 100 * self.ratioWidth, height: 22 * self.ratioHeight))
        labelPeriod.text = self.alarmPeriod
        labelPeriod.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
        labelPeriod.textColor = UIColor.white
        self.addSubview(labelPeriod)
        // swich
        let sw = UISwitch.init(frame: CGRect.init(x: 310 * self.ratioWidth, y: 33 * self.ratioHeight, width: 50*self.ratioWidth, height: 28*self.ratioHeight))
        sw.isOn = true
        self.addSubview(sw)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
