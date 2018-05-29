//
//  Setting.swift
//  EmoClock
//
//  Created by 李博闻 on 2018/3/4.
//  Copyright © 2018年 艺林. All rights reserved.
//

import UIKit

class Setting: UIViewController, UITableViewDelegate, UITableViewDataSource {
    /* global var: the size of the frame */
    var frameHeight: CGFloat = 0.0
    var frameWidth: CGFloat = 0.0
    /* global var: the ratio of the current frame */
    var ratioWidth: CGFloat = 0.0
    var ratioHeight: CGFloat = 0.0
    /* global color */
    let backColor = UIColor.init(red: 0.0, green: 33/255, blue: 49/255, alpha: 1.0)
    /* content of tv */
    let item = ["起床心情自测", "更新歌曲库", "常见问题", "统计"]
    /* iphone6 frame width and height*/
    let IPHONE6_WIDTH: CGFloat = 375.0
    let IPHONE6_HEIGHT: CGFloat = 667.0
    /* platform */
    let platform = UIDevice.current.modelName
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("Setting: viewDidLoad")
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
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
        /* set the nav bar*/
        setNavBarStyle()
        /* set the tv */
        setTv()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNavBarStyle() {
        if platform == "iPhone X" || (frameWidth == 375.0 && frameHeight == 812.0)
        {
            let barView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frameWidth, height: 89))
            barView.backgroundColor = self.backColor
            
            //let label = UILabel.init(frame: CGRect.init(x: 161.5*self.ratioWidth, y: 34.5*self.ratioHeight, width: 52*self.ratioWidth, height: 15.5*self.ratioHeight))
            let label = UILabel.init(frame: CGRect.init(x: 0, y: 53, width: self.frameWidth, height: 21*self.ratioHeight))
            label.textColor = UIColor.white
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
            label.text = "设置"
            barView.addSubview(label)
            
            let itemImageLeft = UIImage.init(named: "back")
            let btnLeft = UIButton.init(frame: CGRect.init(x: 15, y: 56, width: 47 * self.ratioWidth, height: 21 * self.ratioHeight))
            btnLeft.setImage(itemImageLeft, for: UIControlState.normal)
            barView.addSubview(btnLeft)
            btnLeft.addTarget(self, action: #selector(back), for: .touchUpInside)
            
            self.view.addSubview(barView)
        }
        else
        {
            let barView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frameWidth, height: 64.5*self.ratioHeight))
            barView.backgroundColor = self.backColor
            
            //let label = UILabel.init(frame: CGRect.init(x: 161.5*self.ratioWidth, y: 34.5*self.ratioHeight, width: 52*self.ratioWidth, height: 15.5*self.ratioHeight))
            let label = UILabel.init(frame: CGRect.init(x: 0, y: 34.5*self.ratioHeight, width: self.frameWidth, height: 21*self.ratioHeight))
            label.textColor = UIColor.white
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
            label.text = "设置"
            barView.addSubview(label)
            
            let itemImageLeft = UIImage.init(named: "back")
            let btnLeft = UIButton.init(frame: CGRect.init(x: 18 * self.ratioWidth, y: 32 * self.ratioHeight, width: 47 * self.ratioWidth, height: 21 * self.ratioHeight))
            btnLeft.setImage(itemImageLeft, for: UIControlState.normal)
            barView.addSubview(btnLeft)
            btnLeft.addTarget(self, action: #selector(back), for: .touchUpInside)
            
            self.view.addSubview(barView)
        }
        
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setTv() {
        var bg = UIView.init()
        if platform == "iPhone X" || (frameWidth.isEqual(to: 375.0) && frameHeight.isEqual(to: 812.0))
        {
            bg = UIView.init(frame: CGRect.init(x: 0, y: 89.5 * self.ratioHeight, width: self.frameWidth, height: self.frameHeight - 65 * self.ratioHeight))
        }
        else
        {
            bg = UIView.init(frame: CGRect.init(x: 0, y: 65 * self.ratioHeight, width: self.frameWidth, height: self.frameHeight - 65 * self.ratioHeight))
        }
        bg.backgroundColor = self.backColor
        
        let tv = UITableView.init(frame: CGRect.init(x: 16 * self.ratioWidth, y: 0, width: self.frameWidth, height: self.frameHeight - 65 * self.ratioHeight))
        tv.backgroundColor = self.backColor
        tv.separatorStyle = UITableViewCellSeparatorStyle.none
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView.init()
        bg.addSubview(tv)
        self.view.addSubview(bg)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 47 * self.ratioHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(frame: CGRect.init(x: 0, y: 0, width: self.frameWidth, height: 75 * self.ratioHeight))
        cell.textLabel?.text = self.item[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = self.backColor
        cell.textLabel?.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
        let selectedView = UIView.init(frame: cell.frame)
        selectedView.backgroundColor = UIColor.init(red: 3/255, green: 37/255, blue: 58/255, alpha: 1)//03253a
        cell.selectedBackgroundView = selectedView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if index == 0 { //心情自测
            self.navigationController?.pushViewController(SelfTest1(), animated: true)
        } else if index == 1 { //更新歌曲
            
        } else if index == 2 { //常见问题
            self.navigationController?.pushViewController(NormalProbles(), animated: true)
        } else { //统计
            self.navigationController?.pushViewController(Statistics(), animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //print("Setting: viewWillAppear")
    }
    
}
