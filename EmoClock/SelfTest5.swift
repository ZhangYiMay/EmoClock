//
//  SelfTest1.swift
//  EmoClock
//
//  Created by 李博闻 on 2018/5/19.
//  Copyright © 2018年 艺林. All rights reserved.
//

import UIKit

class SelfTest5: UIViewController {
    
    /* global var: the size of the frame */
    var frameHeight: CGFloat = 0.0
    var frameWidth: CGFloat = 0.0
    /* global var: the ratio of the current frame */
    var ratioWidth: CGFloat = 0.0
    var ratioHeight: CGFloat = 0.0
    var backup: CGFloat = 0.0
    /* global color */
    let backColor = UIColor.init(red: 0.0, green: 33/255, blue: 49/255, alpha: 1.0)
    /* iphone6 frame width and height*/
    let IPHONE6_WIDTH: CGFloat = 375.0
    let IPHONE6_HEIGHT: CGFloat = 667.0
    /* platform */
    let platform = UIDevice.current.modelName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
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
        /* set the ui of remaining view */
        setBottomView()
    }
    
    func setNavBarStyle() {
        
        if platform == "iPhone X" || (frameWidth == 375.0 && frameHeight == 812.0)
        {
            let barView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frameWidth, height: 89))
            barView.backgroundColor = self.backColor
            
            let label = UILabel.init(frame: CGRect.init(x: 0, y: 53, width: self.frameWidth, height: 24))
            label.textColor = UIColor.white
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.systemFont(ofSize: 16)
            label.text = "起床心情自测"
            barView.addSubview(label)
            
            let itemImageLeft = UIImage.init(named: "shang")
            let btnLeft = UIButton.init(frame: CGRect.init(x: 15, y: 56, width: 62.5 * self.ratioWidth, height: 21 * self.ratioHeight))
            btnLeft.setImage(itemImageLeft, for: UIControlState.normal)
            barView.addSubview(btnLeft)
            btnLeft.addTarget(self, action: #selector(back), for: .touchUpInside)
            
            self.view.addSubview(barView)
        }
        else
        {
            let barView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frameWidth, height: 64.5*self.ratioHeight))
            barView.backgroundColor = self.backColor
            
            let label = UILabel.init(frame: CGRect.init(x: 0, y: 34.5*self.ratioHeight, width: self.frameWidth, height: 15.5*self.ratioHeight))
            label.textAlignment = .center
            label.textColor = UIColor.white
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
            label.text = "起床心情自测"
            barView.addSubview(label)
            
            let itemImageLeft = UIImage.init(named: "shang")
            let btnLeft = UIButton.init(frame: CGRect.init(x: 18 * self.ratioWidth, y: 32 * self.ratioHeight, width: 62.5 * self.ratioWidth, height: 21 * self.ratioHeight))
            btnLeft.setImage(itemImageLeft, for: UIControlState.normal)
            barView.addSubview(btnLeft)
            btnLeft.addTarget(self, action: #selector(back), for: .touchUpInside)
            
            self.view.addSubview(barView)
        }
    }
    
    func setBottomView() {
        var bottomView = UIView.init()
        if platform == "iPhone X" || (frameWidth == 375.0 && frameHeight == 812.0)
        {
            bottomView = UIView.init(frame: CGRect.init(x: 0, y: 89.5 * self.ratioHeight, width: self.frameWidth, height: self.frameHeight - 89.5 * self.ratioHeight))
        }
        else
        {
            bottomView = UIView.init(frame: CGRect.init(x: 0, y: 65.0 * self.ratioHeight, width: self.frameWidth, height: self.frameHeight - 65.0 * self.ratioHeight))
        }
        bottomView.backgroundColor = self.backColor
        //label 1
        let label1 = UILabel.init(frame: CGRect.init(x: 0, y: 57 * self.ratioHeight, width: self.frameWidth, height: 21.5 * self.ratioHeight))
        label1.text = "5/6"
        label1.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
        label1.textAlignment = .center
        label1.textColor = UIColor.white
        bottomView.addSubview(label1)
        // label 2
        let label2 = UILabel.init(frame: CGRect.init(x: 0, y: 100 * self.ratioHeight, width: self.frameWidth, height: 21.5 * self.ratioHeight))
        label2.text = "请问您起床后，会有情绪不佳的情况吗？"
        label2.font = UIFont.boldSystemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
        label2.textAlignment = .center
        label2.textColor = UIColor.white
        bottomView.addSubview(label2)
        // button 1
        //let button1 = UIButton.init(frame: CGRect(x: 147.5 * self.ratioWidth, y: 208.5 * self.ratioHeight, width: 80 * self.ratioWidth, height: 21.5 * self.ratioHeight))
        let button1 = UIButton.init(frame: CGRect(x: 80 * self.ratioWidth, y: 184 * self.ratioHeight, width: 247.5 * self.ratioWidth, height: 34.5 * self.ratioHeight))
        button1.setImage(UIImage(named: "test51"), for: .normal)
        bottomView.addSubview(button1)
        button1.addTarget(self, action: #selector(gotoNext1), for: .touchUpInside)
        // button 2
        let button2 = UIButton.init(frame: CGRect(x: 80 * self.ratioWidth, y: 267 * self.ratioHeight, width: 189 * self.ratioWidth, height: 34.5 * self.ratioHeight))
        button2.setImage(UIImage(named: "test52"), for: .normal)
        bottomView.addSubview(button2)
        button2.addTarget(self, action: #selector(gotoNext2), for: .touchUpInside)
        bottomView.addSubview(button2)
        // button 3
        let button3 = UIButton.init(frame: CGRect(x: 80 * self.ratioWidth, y: 353.5 * self.ratioHeight, width: 217 * self.ratioWidth, height: 34.5 * self.ratioHeight))
        button3.setImage(UIImage(named: "test53"), for: .normal)
        bottomView.addSubview(button3)
        button3.addTarget(self, action: #selector(gotoNext3), for: .touchUpInside)
        bottomView.addSubview(button3)
        // button 4
        let button4 = UIButton.init(frame: CGRect(x: 80 * self.ratioWidth, y: 440 * self.ratioHeight, width: 202 * self.ratioWidth, height: 34.5 * self.ratioHeight))
        button4.setImage(UIImage(named: "test54"), for: .normal)
        bottomView.addSubview(button4)
        button4.addTarget(self, action: #selector(gotoNext4), for: .touchUpInside)
        bottomView.addSubview(button4)
        
        self.view.addSubview(bottomView)
    }
    @objc func gotoNext1() {
        let self6 = SelfTest6()
        self6.point_happy = 1.0
        self.navigationController?.pushViewController(self6, animated: true)
    }
    @objc func gotoNext2() {
        let self6 = SelfTest6()
        self6.point_happy = 3.3
        self.navigationController?.pushViewController(self6, animated: true)
    }
    @objc func gotoNext3() {
        let self6 = SelfTest6()
        self6.point_happy = 5.6
        self.navigationController?.pushViewController(self6, animated: true)
    }
    @objc func gotoNext4() {
        let self6 = SelfTest6()
        self6.point_happy = 9.0
        self.navigationController?.pushViewController(self6, animated: true)
    }
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
}


