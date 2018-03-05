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
    let item = ["起床心情自判", "音量设置", "常见问题"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* get the size of the frame */
        self.frameHeight = self.view.frame.height
        self.frameWidth = self.view.frame.width
        self.ratioWidth = self.frameWidth / 375.0
        self.ratioHeight = self.frameHeight / 667.0
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
        let barView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frameWidth, height: 64.5*self.ratioHeight))
        barView.backgroundColor = self.backColor
        
        let label = UILabel.init(frame: CGRect.init(x: 161.5*self.ratioWidth, y: 34.5*self.ratioHeight, width: 52*self.ratioWidth, height: 15.5*self.ratioHeight))
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: round(16*self.ratioHeight*self.ratioWidth))
        label.text = "Setting"
        barView.addSubview(label)
        
        let itemImageLeft = UIImage.init(named: "back")
        let btnLeft = UIButton.init(frame: CGRect.init(x: 18 * self.ratioWidth, y: 32 * self.ratioHeight, width: 12.5 * self.ratioWidth, height: 21 * self.ratioHeight))
        btnLeft.setImage(itemImageLeft, for: UIControlState.normal)
        barView.addSubview(btnLeft)
        btnLeft.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        self.view.addSubview(barView)
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setTv() {
        let bg = UIView.init(frame: CGRect.init(x: 0, y: 65 * self.ratioHeight, width: self.frameWidth, height: self.frameHeight - 65 * self.ratioHeight))
        bg.backgroundColor = self.backColor
        self.view.addSubview(bg)
        let tv = UITableView.init(frame: CGRect.init(x: 16 * self.ratioWidth, y: 65 * self.ratioHeight, width: self.frameWidth, height: self.frameHeight - 65 * self.ratioHeight))
        tv.backgroundColor = self.backColor
        tv.separatorStyle = UITableViewCellSeparatorStyle.none
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView.init()
        self.view.addSubview(tv)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 47 * self.ratioHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(frame: CGRect.init(x: 0, y: 0, width: self.frameWidth, height: 75 * self.ratioHeight))
        cell.textLabel?.text = self.item[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = self.backColor
        cell.textLabel?.font = UIFont.systemFont(ofSize: round(18 * self.ratioHeight * ratioWidth))
        return cell
    }
}
