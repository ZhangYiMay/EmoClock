//
//  Feedback.swift
//  EmoClock
//
//  Created by 李博闻 on 2018/3/5.
//  Copyright © 2018年 艺林. All rights reserved.
//

import UIKit

class Feedback: UIViewController {
    
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
    /* alarm info */
    var alarm_hour = 0
    var alarm_minute = 0
    var alarm_month = 0
    var alarm_day = 0
    var alarm_week = 0
    var alarm_music = ""
    let weekCh = ["一", "二", "三", "四", "五", "六", "日"]
    /* points */
    var point_happy: Float = 1.0
    var point_sober: Float = 1.0
    /* face imviews */
    var ivh_small: [UIImageView] = []
    var ivh_big: [UIImageView] = []
    var ivs_small: [UIImageView] = []
    var ivs_big: [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.isNavigationBarHidden = true
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
        label_time.text = "\(self.alarm_hour):" + (self.alarm_minute < 10 ? "0\(self.alarm_minute)" : "\(self.alarm_minute)")
        label_time.textColor = UIColor.white
        label_time.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 50))
        self.view.addSubview(label_time)
        // label: date
        //let label_date = UILabel.init(frame: CGRect.init(x: 136.5*self.ratioWidth, y: 150.5*self.ratioHeight, width: 102*self.ratioWidth, height: 15.5*self.ratioHeight))
        let label_date = UILabel.init(frame: CGRect.init(x: 0, y: 150.5*self.ratioHeight, width: self.frameWidth, height: 15.5*self.ratioHeight))
        label_date.textAlignment = .center
        label_date.text = ((self.alarm_month < 10 ? "0\(self.alarm_month)" : "\(self.alarm_month)") + "." + (self.alarm_day < 10 ? "0\(self.alarm_day)日" : "\(self.alarm_day)日") + " 星期" + self.weekCh[self.alarm_week])
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
        label_eng.text = self.alarm_music
        label_eng.textColor = UIColor.white
        label_eng.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
        self.view.addSubview(label_eng)
        // slider area
        // label1
        let label_feel = UILabel.init(frame: CGRect.init(x: 14.5*self.ratioWidth, y: 323*self.ratioHeight, width: 102*self.ratioWidth, height: 21*self.ratioHeight))
        label_feel.text = "感觉如何?"
        label_feel.textColor = UIColor.white
        label_feel.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 20))
        self.view.addSubview(label_feel)
        // label1
        let label1 = UILabel.init(frame: CGRect.init(x: 14.5*self.ratioWidth, y: 408*self.ratioHeight, width: 50*self.ratioWidth, height: 12.5*self.ratioHeight))
        label1.text = "愉悦程度"
        label1.textColor = UIColor.white
        label1.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 12))
        self.view.addSubview(label1)
        // slider1
        let slider1 = UISlider.init(frame: CGRect.init(x: 77*self.ratioWidth, y: 413.5*self.ratioHeight, width: 280*self.ratioWidth, height: 10))
        slider1.minimumValue = 1
        slider1.maximumValue = 9
        slider1.value = 1
        slider1.isContinuous = true
        slider1.minimumTrackTintColor = UIColor.init(red: 50/255, green: 136/255, blue: 1, alpha: 1)
        slider1.maximumTrackTintColor = UIColor.init(red: 38/255, green: 53/255, blue: 69/255, alpha: 1)
        self.view.addSubview(slider1)
        slider1.addTarget(self, action: #selector(slider1_event), for: .valueChanged)
        // label2
        let label2 = UILabel.init(frame: CGRect.init(x: 14.5*self.ratioWidth, y: 493*self.ratioHeight, width: 50*self.ratioWidth, height: 12.5*self.ratioHeight))
        label2.text = "清醒程度"
        label2.textColor = UIColor.white
        label2.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 12))
        self.view.addSubview(label2)
        // slider2
        let slider2 = UISlider.init(frame: CGRect.init(x: 77*self.ratioWidth, y: 498.5*self.ratioHeight, width: 280*self.ratioWidth, height: 10))
        slider2.minimumValue = 1
        slider2.maximumValue = 9
        slider2.value = 1
        slider2.isContinuous = true
        slider2.minimumTrackTintColor = UIColor.init(red: 50/255, green: 136/255, blue: 1, alpha: 1)
        slider2.maximumTrackTintColor = UIColor.init(red: 38/255, green: 53/255, blue: 69/255, alpha: 1)
        self.view.addSubview(slider2)
        slider2.addTarget(self, action: #selector(slider2_event), for: .valueChanged)
        /* faces - happy */
        let face_h1_big = UIImageView.init(frame: CGRect.init(x: 72 * self.ratioWidth, y: 354 * self.ratioWidth, width: 34 * self.ratioWidth, height: 34 * self.ratioWidth))
        face_h1_big.image = UIImage.init(named: "face_happy1_big.png")
        self.view.addSubview(face_h1_big)
        self.ivh_big.append(face_h1_big)
        let face_h1_small = UIImageView.init(frame: CGRect.init(x: 81 * self.ratioWidth, y: 370.5 * self.ratioWidth, width: 17.5 * self.ratioWidth, height: 17.5 * self.ratioWidth))
        face_h1_small.image = UIImage.init(named: "face_happy1_small.png")
        face_h1_small.isHidden = true
        self.ivh_small.append(face_h1_small)
        self.view.addSubview(face_h1_small)
        
        let face_h2_small = UIImageView.init(frame: CGRect.init(x: 161.5 * self.ratioWidth, y: 370.5 * self.ratioWidth, width: 17.5 * self.ratioWidth, height: 17.5 * self.ratioWidth))
        face_h2_small.image = UIImage.init(named: "face_happy2_small.png")
        self.view.addSubview(face_h2_small)
        self.ivh_small.append(face_h2_small)
        let face_h2_big = UIImageView.init(frame: CGRect.init(x: 153 * self.ratioWidth, y: 354 * self.ratioWidth, width: 34 * self.ratioWidth, height: 34 * self.ratioWidth))
        face_h2_big.image = UIImage.init(named: "face_happy2_big.png")
        face_h2_big.isHidden = true
        self.ivh_big.append(face_h2_big)
        self.view.addSubview(face_h2_big)
        
        let face_h3_big = UIImageView.init(frame: CGRect.init(x: 233 * self.ratioWidth, y: 354 * self.ratioWidth, width: 34 * self.ratioWidth, height: 34 * self.ratioWidth))
        face_h3_big.image = UIImage.init(named: "face_happy3_big.png")
        face_h3_big.isHidden = true
        self.ivh_big.append(face_h3_big)
        self.view.addSubview(face_h3_big)
        let face_h3_small = UIImageView.init(frame: CGRect.init(x: 242 * self.ratioWidth, y: 370.5 * self.ratioWidth, width: 17.5 * self.ratioWidth, height: 17.5 * self.ratioWidth))
        face_h3_small.image = UIImage.init(named: "face_happy3_small.png")
        self.view.addSubview(face_h3_small)
        self.ivh_small.append(face_h3_small)
        
        let face_h4_big = UIImageView.init(frame: CGRect.init(x: 314 * self.ratioWidth, y: 354 * self.ratioWidth, width: 34 * self.ratioWidth, height: 34 * self.ratioWidth))
        face_h4_big.image = UIImage.init(named: "face_happy4_big.png")
        face_h4_big.isHidden = true
        self.ivh_big.append(face_h4_big)
        self.view.addSubview(face_h4_big)
        let face_h4_small = UIImageView.init(frame: CGRect.init(x: 322.5 * self.ratioWidth, y: 370.5 * self.ratioWidth, width: 17.5 * self.ratioWidth, height: 17.5 * self.ratioWidth))
        face_h4_small.image = UIImage.init(named: "face_happy4_small.png")
        self.view.addSubview(face_h4_small)
        self.ivh_small.append(face_h4_small)
        /* faces - sober */
        let face_s1_big = UIImageView.init(frame: CGRect.init(x: 72 * self.ratioWidth, y: 439 * self.ratioWidth, width: 34 * self.ratioWidth, height: 34 * self.ratioWidth))
        face_s1_big.image = UIImage.init(named: "face_sober1_big.png")
        self.view.addSubview(face_s1_big)
        face_s1_big.isHidden = false
        self.ivs_big.append(face_s1_big)
        let face_s1_small = UIImageView.init(frame: CGRect.init(x: 81 * self.ratioWidth, y: 455.5 * self.ratioWidth, width: 17.5 * self.ratioWidth, height: 17.5 * self.ratioWidth))
        face_s1_small.image = UIImage.init(named: "face_sober1_small.png")
        self.view.addSubview(face_s1_big)
        face_s1_small.isHidden = true
        self.view.addSubview(face_s1_small)
        self.ivs_small.append(face_s1_small)
        
        let face_s2_big = UIImageView.init(frame: CGRect.init(x: 153 * self.ratioWidth, y: 439 * self.ratioWidth, width: 34 * self.ratioWidth, height: 34 * self.ratioWidth))
        face_s2_big.image = UIImage.init(named: "face_sober2_big.png")
        face_s2_big.isHidden = true
        self.ivs_big.append(face_s2_big)
        self.view.addSubview(face_s2_big)
        let face_s2_small = UIImageView.init(frame: CGRect.init(x: 161.5 * self.ratioWidth, y: 455.5 * self.ratioWidth, width: 17.5 * self.ratioWidth, height: 17.5 * self.ratioWidth))
        face_s2_small.image = UIImage.init(named: "face_sober2_small.png")
        face_s2_small.isHidden = false
        self.ivs_small.append(face_s2_small)
        self.view.addSubview(face_s2_small)
        
        let face_s3_big = UIImageView.init(frame: CGRect.init(x: 233 * self.ratioWidth, y: 439 * self.ratioWidth, width: 34 * self.ratioWidth, height: 34 * self.ratioWidth))
        face_s3_big.image = UIImage.init(named: "face_sober3_big.png")
        face_s3_big.isHidden = true
        self.ivs_big.append(face_s3_big)
        self.view.addSubview(face_s3_big)
        let face_s3_small = UIImageView.init(frame: CGRect.init(x: 242 * self.ratioWidth, y: 455.5 * self.ratioWidth, width: 17.5 * self.ratioWidth, height: 17.5 * self.ratioWidth))
        face_s3_small.image = UIImage.init(named: "face_sober3_small.png")
        face_s3_small.isHidden = false
        self.ivs_small.append(face_s3_small)
        self.view.addSubview(face_s3_small)
        
        let face_s4_big = UIImageView.init(frame: CGRect.init(x: 314 * self.ratioWidth, y: 439 * self.ratioWidth, width: 34 * self.ratioWidth, height: 34 * self.ratioWidth))
        face_s4_big.image = UIImage.init(named: "face_sober4_big.png")
        face_s4_big.isHidden = true
        self.ivs_big.append(face_s4_big)
        self.view.addSubview(face_s4_big)
        let face_s4_small = UIImageView.init(frame: CGRect.init(x: 322.5 * self.ratioWidth, y: 455.5 * self.ratioWidth, width: 17.5 * self.ratioWidth, height: 17.5 * self.ratioWidth))
        face_s4_small.image = UIImage.init(named: "face_sober4_small.png")
        face_s4_small.isHidden = false
        self.ivs_small.append(face_s4_small)
        self.view.addSubview(face_s4_small)
        
        // button save
        let btnRect = CGRect.init(x: 46.5 * self.ratioWidth, y: 555.5*self.ratioHeight, width: 280 * self.ratioWidth, height: 57 * self.ratioHeight)
        let buttonSave = UIButton.init(frame: btnRect)
        buttonSave.layer.masksToBounds = true
        buttonSave.layer.cornerRadius = 30 * self.ratioWidth
        buttonSave.backgroundColor = UIColor.init(red: 50/255, green: 136/255, blue: 1, alpha: 1)
        //let label = UILabel.init(frame: CGRect.init(x: 96 * self.ratioWidth, y: 16.5 * self.ratioHeight, width: 88.5 * self.ratioWidth, height: 23.5 * self.ratioHeight))
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 16.5 * self.ratioHeight, width: buttonSave.frame.width, height: 23.5 * self.ratioHeight))
        label.textAlignment = .center
        label.text = "完成 Save"
        label.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 20))
        label.textColor = UIColor.white
        buttonSave.addSubview(label)
        self.view.addSubview(buttonSave)
        buttonSave.addTarget(self, action: #selector(tapSave), for: UIControlEvents.touchUpInside)
    }
    
    @objc func slider1_event(sender: UISlider) {
        let v = sender.value
        //print("v:\(v)")
        self.point_happy = v
        if v <= 2.2 {
            self.ivh_small[0].isHidden = true
            self.ivh_big[0].isHidden = false
            self.ivh_small[1].isHidden = false
            self.ivh_big[1].isHidden = true
        } else if v > 2.2 && v <= 4.8 {
            self.ivh_small[0].isHidden = false
            self.ivh_big[0].isHidden = true
            self.ivh_small[1].isHidden = true
            self.ivh_big[1].isHidden = false
            self.ivh_small[2].isHidden = false
            self.ivh_big[2].isHidden = true
        } else if v > 4.8 && v <= 7.5 {
            self.ivh_small[1].isHidden = false
            self.ivh_big[1].isHidden = true
            self.ivh_small[2].isHidden = true
            self.ivh_big[2].isHidden = false
            self.ivh_small[3].isHidden = false
            self.ivh_big[3].isHidden = true
        } else {
            self.ivh_small[2].isHidden = false
            self.ivh_big[2].isHidden = true
            self.ivh_small[3].isHidden = true
            self.ivh_big[3].isHidden = false
        }
    }
    @objc func slider2_event(sender: UISlider) {
        let v = sender.value
        self.point_sober = v
        if v <= 2.2 {
            self.ivs_small[0].isHidden = true
            self.ivs_big[0].isHidden = false
            self.ivs_small[1].isHidden = false
            self.ivs_big[1].isHidden = true
        } else if v > 2.2 && v <= 4.8 {
            self.ivs_small[0].isHidden = false
            self.ivs_big[0].isHidden = true
            self.ivs_small[1].isHidden = true
            self.ivs_big[1].isHidden = false
            self.ivs_small[2].isHidden = false
            self.ivs_big[2].isHidden = true
        } else if v > 4.8 && v <= 7.5 {
            self.ivs_small[1].isHidden = false
            self.ivs_big[1].isHidden = true
            self.ivs_small[2].isHidden = true
            self.ivs_big[2].isHidden = false
            self.ivs_small[3].isHidden = false
            self.ivs_big[3].isHidden = true
        } else {
            self.ivs_small[2].isHidden = false
            self.ivs_big[2].isHidden = true
            self.ivs_small[3].isHidden = true
            self.ivs_big[3].isHidden = false
        }
    }
    @objc func tapSave() {
        /*write points into files*/
        let path = StoreFileManager.getStoragePath(suffix: "/EmoClock/Points/")
        let filePathHappy = path + "happy.txt"
        print("store point path:\(filePathHappy)")
        var happyArr: Array<Float> = []
        if FileManager.default.fileExists(atPath: filePathHappy) {
            happyArr = StoreFileManager.readFileAtPath(path: filePathHappy) as! Array<Float>
        }
        happyArr.append(self.point_happy)
        StoreFileManager.storeFileToPath(path: filePathHappy, info: NSArray.init(array: happyArr))
        
        let filePathSober = path + "sober.txt"
        var soberArr: Array<Float> = []
        if FileManager.default.fileExists(atPath: filePathSober) {
            soberArr = StoreFileManager.readFileAtPath(path: filePathSober) as! Array<Float>
        }
        soberArr.append(self.point_sober)
        StoreFileManager.storeFileToPath(path: filePathSober, info: NSArray.init(array: soberArr))
        /*jump to mainpage*/
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MainPage")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
