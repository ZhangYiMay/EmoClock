//
//  MusicChosen.swift
//  EmoClock
//
//  Created by 李博闻 on 2018/5/6.
//  Copyright © 2018年 艺林. All rights reserved.
//

import UIKit

class MusicChose {
    fileprivate let music = [["5"  , "100", "411",  "411"],
                             ["8"  , "4"  , "1"  ,  "1"],
                             ["520", "6"  , "7"  , "33"],
                             ["372", "494", "13" , "18"],]
    
    fileprivate func getPoint()->(Float, Float) {
        var pv: Float = 2.0
        var pa: Float = 2.0
        let path_v = StoreFileManager.getStoragePath(suffix: "/EmoClock/Points/") + "happy.txt"
        let content_v = StoreFileManager.readFileAtPath(path: path_v) as! Array<Float>
        if !content_v.isEmpty {
            pv = content_v.last!
        } else { //查看selftest的结果
            let path = StoreFileManager.getStoragePath(suffix: "/EmoClock/Test/musicKind.txt")
            let content = StoreFileManager.readFileAtPath(path: path) as! Array<Float>
            if !content.isEmpty {
                pa = content[1]
                pv = content[0]
            }
        }
        
        let path_a = StoreFileManager.getStoragePath(suffix: "/EmoClock/Points/") + "sober.txt"
        let content_a = StoreFileManager.readFileAtPath(path: path_a) as! Array<Float>
        if !content_a.isEmpty {
            pa = content_a.last!
        }
        assert(content_a.isEmpty == content_v.isEmpty)
        return (pv, pa)
    }
    
    func getMusic()->String {
        var pv: Float = 2.0
        var pa: Float = 2.0
        (pv, pa) = self.getPoint()
        var name = ""
        var v = 0
        var a = 0
        if pv < 3 {
            v = 0
        } else if pv >= 3 && pv < 5 {
            v = 1
        } else if pv >= 5 && pv < 7 {
            v = 2
        } else {
            v = 3
        }
        if pa < 3 {
            a = 0
        } else if pa >= 3 && pa < 5 {
            a = 1
        } else if pa >= 5 && pa < 7 {
            a = 2
        } else {
            a = 3
        }
        name = music[a][v]
        if name == "" {
            name = music[a][v-1]
        }
        return name
    }
}
