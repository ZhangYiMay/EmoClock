//
//  MainPage.swift
//  EmoClock
//
//  Created by 李博闻 on 2018/3/3.
//  Copyright © 2018年 艺林. All rights reserved.
//
//  首页

import UIKit

class MainPage: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    /* global var: the size of the frame */
    var frameHeight: CGFloat = 0.0
    var frameWidth: CGFloat = 0.0
    /* global var: the ratio of the current frame */
    var ratioWidth: CGFloat = 0.0
    var ratioHeight: CGFloat = 0.0
    /* global color */
    let backColor = UIColor.init(red: 0.0, green: 33/255, blue: 49/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.isHidden = true
        /* get the size of the frame */
        self.frameHeight = self.view.frame.height
        self.frameWidth = self.view.frame.width
        self.ratioWidth = self.frameWidth / 375.0
        self.ratioHeight = self.frameHeight / 667.0
        self.view.backgroundColor = UIColor.gray
        print("framewidth: \(self.frameWidth), frameheight: \(self.frameHeight)")
        
        /* set the ui of navigation bar */
        setNavBarStyle()
        
        /* set the background of the picker view */
        setPickerStyle()
        
        /* set the bottom view */
        setBottomView()
    }
    
    func setNavBarStyle() {
        let barView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frameWidth, height: 64.5*self.ratioHeight))
        barView.backgroundColor = self.backColor
        
        let label = UILabel.init(frame: CGRect.init(x: 151*self.ratioWidth, y: 34.5*self.ratioHeight, width: 73*self.ratioWidth, height: 15.5*self.ratioHeight))
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: round(16*self.ratioHeight*self.ratioWidth))
        label.text = "EmoClock"
        barView.addSubview(label)
        
        let itemImageLeft = UIImage.init(named: "statistics")
        let btnLeft = UIButton.init(frame: CGRect.init(x: 15 * self.ratioWidth, y: 32 * self.ratioHeight, width: 23.5 * self.ratioWidth, height: 20 * self.ratioHeight))
        btnLeft.setImage(itemImageLeft, for: UIControlState.normal)
        barView.addSubview(btnLeft)
        
        
        let itemImageRight = UIImage.init(named: "set")
        let btnRight = UIButton.init(frame: CGRect.init(x: 335 * self.ratioWidth, y: 28 * self.ratioHeight, width: 28 * self.ratioWidth, height: 28 * self.ratioHeight))
        btnRight.setImage(itemImageRight, for: UIControlState.normal)
        barView.addSubview(btnRight)
        btnRight.addTarget(self, action: #selector(tapSetting), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(barView)
    }
    
    func setPickerStyle() {
        let pickerBackView = UIView.init(frame: CGRect.init(x: 0, y: 65.0 * self.ratioHeight, width: self.frameWidth, height: 496.0 * self.ratioHeight))
        pickerBackView.backgroundColor = UIColor.init(red: 0.0, green: 33/255, blue: 49/255, alpha: 1.0)
        let imView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.frameWidth, height: 496.0 * self.ratioHeight))
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
        let label = UILabel.init(frame: CGRect.init(x: 96.5 * self.ratioWidth, y: 16.5 * self.ratioHeight, width: 87.5 * self.ratioWidth, height: 23.5 * self.ratioHeight))
        label.text = "开始 Start"
        label.font = UIFont.systemFont(ofSize: round(20*self.ratioHeight*self.ratioWidth))
        label.textColor = UIColor.white
        buttonStart.addSubview(label)
        bottomView.addSubview(buttonStart)
        self.view.addSubview(bottomView)
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
        label.font = UIFont.systemFont(ofSize: round(22*self.ratioWidth*self.ratioHeight))
        label.textAlignment = NSTextAlignment.center
        return label
    }
    
    /* monitor button setting */
    @objc func tapSetting() {
        print("tapping...")
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "setting") as UIViewController
        //self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
