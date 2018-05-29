//
//  SelfTest1.swift
//  EmoClock
//
//  Created by 李博闻 on 2018/5/19.
//  Copyright © 2018年 艺林. All rights reserved.
//

import UIKit

class SelfTest4: UIViewController {
    
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
    /* music kinds from page 3 */
    var music_qj: Float = 0.0 //y值
    
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
        label1.text = "4/6"
        label1.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
        label1.textAlignment = .center
        label1.textColor = UIColor.white
        bottomView.addSubview(label1)
        // label 2
        let label2 = UILabel.init(frame: CGRect.init(x: 0, y: 100 * self.ratioHeight, width: self.frameWidth, height: 21.5 * self.ratioHeight))
        label2.text = "请问您更喜欢愉快的还是惆怅的起床铃声？"
        label2.font = UIFont.boldSystemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
        label2.textAlignment = .center
        label2.textColor = UIColor.white
        bottomView.addSubview(label2)
        // button right
        let buttonGril = UIButton.init(frame: CGRect(x: 214.5 * self.ratioWidth, y: 239 * self.ratioHeight, width: 103 * self.ratioWidth, height: 165 * self.ratioHeight))
        buttonGril.setImage(UIImage(named: "testsad"), for: .normal)
        bottomView.addSubview(buttonGril)
        buttonGril.addTarget(self, action: #selector(gotoNextsad), for: .touchUpInside)
        // button left
        let buttonBoy = UIButton.init(frame: CGRect(x: 50 * self.ratioWidth, y: 239 * self.ratioHeight, width: 103 * self.ratioWidth, height: 165 * self.ratioHeight))
        buttonBoy.setImage(UIImage(named: "testhappy"), for: .normal)
        bottomView.addSubview(buttonBoy)
        buttonBoy.addTarget(self, action: #selector(gotoNexthappy), for: .touchUpInside)
        
        self.view.addSubview(bottomView)
    }
    @objc func gotoNexthappy() {
        let path = StoreFileManager.getStoragePath(suffix: "/EmoClock/Test/musicKind.txt")
        StoreFileManager.clearDirectory(path: path)
        let kind = [5.0, self.music_qj] as NSArray
        StoreFileManager.storeFileToPath(path: path, info: kind)
        self.navigationController?.pushViewController(SelfTest5(), animated: true)
    }
    @objc func gotoNextsad() {
        let path = StoreFileManager.getStoragePath(suffix: "/EmoClock/Test/musicKind.txt")
        StoreFileManager.clearDirectory(path: path)
        let kind = [3.0, self.music_qj] as NSArray
        StoreFileManager.storeFileToPath(path: path, info: kind)
        self.navigationController?.pushViewController(SelfTest5(), animated: true)
    }
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
}

