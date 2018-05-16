//
//  GuideView.swift
//  EmoClock
//
//  Created by 李博闻 on 2018/5/5.
//  Copyright © 2018年 艺林. All rights reserved.
//

import UIKit

class GuideView: UIViewController, UIScrollViewDelegate {
    
    var startBtn = UIButton.init()
    var pageControl = UIPageControl.init()
    let picNum = 4
    let bigWords = ["告别起床气","闹铃不重样","睡眠云端存"]
    let smallWords = ["适合你的情感化音乐唤醒","海量曲库每天都是适合你的音乐","登录后睡眠数据云端存储"]
    
    /* iphone6 frame width and height*/
    let IPHONE6_WIDTH: CGFloat = 375.0
    let IPHONE6_HEIGHT: CGFloat = 667.0
    /* global var: the ratio of the current frame */
    var ratioWidth: CGFloat = 0.0
    var ratioHeight: CGFloat = 0.0
    var backup: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = self.view.frame
        self.ratioWidth = frame.width / IPHONE6_WIDTH
        self.ratioHeight = frame.height / IPHONE6_HEIGHT
        if self.ratioWidth < self.ratioHeight {
            self.backup = self.ratioHeight
            self.ratioHeight = self.ratioWidth
        } else {
            self.backup = self.ratioWidth
            self.ratioWidth = self.ratioHeight
        }
        self.navigationController?.navigationBar.isHidden = true
        
        self.pageControl = UIPageControl.init(frame: CGRect.init(x: 150, y: 650, width: 100, height: 40))
        self.pageControl.numberOfPages = 4
        self.pageControl.currentPageIndicatorTintColor = UIColor.blue
        self.pageControl.pageIndicatorTintColor = UIColor.gray
        self.view.addSubview(pageControl)
        
        let scrollView = UIScrollView.init(frame: frame)
        scrollView.isPagingEnabled = true
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentOffset = CGPoint.zero
        scrollView.contentSize = CGSize.init(width: CGFloat(picNum)*frame.width, height: 0)
        scrollView.delegate = self
        for index in 0..<picNum {
            let pageView = UIView.init(frame: CGRect.init(x: CGFloat(index) * frame.width, y: 0, width: frame.width, height: frame.height))
            let imgView = UIImageView.init(frame: CGRect.init(x: 56 * self.ratioWidth, y: 126 * self.ratioHeight, width: 263 * self.ratioWidth, height: 242 * self.ratioHeight))
            imgView.image = UIImage.init(named: "guide\(index+1).png")
            pageView.addSubview(imgView)
            // words
            if index != picNum - 1 {
                let label1 = UILabel.init(frame: CGRect.init(x: 0, y: 493 * self.ratioHeight, width: frame.width, height: 42 * self.ratioHeight))
                label1.text = self.bigWords[index]
                label1.textAlignment = .center
                label1.font = UIFont.boldSystemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 30))
                label1.textColor = UIColor.init(red: 50/255, green: 136/255, blue: 1.0, alpha: 1.0)
                pageView.addSubview(label1)
                
                let label2 = UILabel.init(frame: CGRect.init(x: 0, y: 547 * self.ratioHeight, width: frame.width, height: 21 * self.ratioHeight))
                label2.text = self.smallWords[index]
                label2.textAlignment = .center
                label2.font = UIFont.systemFont(ofSize: FontSizeAdaptor.adaptFontSize(fontSize: 15))
                label2.textColor = UIColor.init(red: 171/255, green: 171/255, blue: 171/255, alpha: 1.0)
                pageView.addSubview(label2)
            }
            scrollView.addSubview(pageView)
        }
        //self.view.addSubview(scrollView)
        self.view.insertSubview(scrollView, at: 0)
        /*button*/
        self.startBtn = UIButton.init(frame: CGRect.init(x: 47.5 * self.ratioWidth, y: 502 * self.ratioHeight, width: 280 * self.ratioWidth, height: 79 * self.ratioHeight))
        //startBtn.setBackgroundImage(UIImage.init(named: "guideb.png"), for: UIControlState.highlighted)
        startBtn.setImage(UIImage.init(named: "guideb.png"), for: .normal)
        //startBtn.backgroundColor = UIColor.blue
        startBtn.alpha = 0.0
        self.view.addSubview(startBtn)
        startBtn.addTarget(self, action: #selector(enterMainPage), for: .touchUpInside)
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    @objc func enterMainPage() {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MainPage")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension GuideView {
    //override
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        // 随着滑动改变pageControl的状态
        let currentPage = Int(offset.x / self.view.bounds.width)
        pageControl.currentPage = currentPage
        // 因为currentPage是从0开始，所以numOfPages减1
        if currentPage == self.picNum - 1 {
            UIView.animate(withDuration: 0.3, animations: {
                self.startBtn.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.startBtn.alpha = 0.0
            })
        }
    }
}
