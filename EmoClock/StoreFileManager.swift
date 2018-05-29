//
//  FileManager.swift
//  EmoClock
//
//  Created by 李博闻 on 2018/4/26.
//  Copyright © 2018年 艺林. All rights reserved.
//

import UIKit

class StoreFileManager {
    
    static let manager = FileManager.default
    
    static func getStoragePath(suffix: String)->String {
        let allPath: NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let onePath = (allPath[0] as! String) + suffix
        
        if !self.manager.fileExists(atPath: onePath) {
            try! manager.createDirectory(at: URL.init(string: "file://"+onePath)!, withIntermediateDirectories: true, attributes: nil)
        }
        return onePath
    }
    
    static func clearDirectory(path: String) {
        let exist = manager.fileExists(atPath: path)
        if exist {
            try! manager.removeItem(at: URL.init(string: "file://"+path)!)
        }
    }
    
    static func storeFileToPath(path: String, info: NSArray) {
        info.write(toFile: path, atomically: true)
        //print("info write success:\(info[0])")
    }
    
    static func readFileAtPath(path: String) -> Array<Any> {
        //var content: Array<Dictionary<String, Any>> = []
        var content: Array<Any> = []
        if manager.fileExists(atPath: path) {
            content = NSArray.init(contentsOfFile: path) as! Array<Any>//Array<Dictionary<String, Any>>
            /*if content != nil {
                alarmInfo = content![0] as! Dictionary<String, Any>
                print(alarmInfo)
            }*/
        }
        return content
    }
}
