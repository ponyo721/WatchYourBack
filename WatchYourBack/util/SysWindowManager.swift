//
//  SysWindowManager.swift
//  BlockMyApp
//
//  Created by byeongho park on 11/25/24.
//

import Cocoa

class SysWindowManager: NSObject {
    
    func getAllVisibleWindowInfoList() -> [[String : Any]] {
        let options = CGWindowListOption(arrayLiteral: .optionOnScreenOnly, .excludeDesktopElements)
        let windowsListInfo = CGWindowListCopyWindowInfo(options, CGWindowID(0))
        let infoList = windowsListInfo as! [[String:Any]]
        let visibleWindows = infoList.filter{$0["kCGWindowLayer"] as! Int == 0}
        
        for window in visibleWindows {
            print(window)
            print("window Name: \(window["kCGWindowOwnerName"] as! String)")
        }
        
        visibleWindows.forEach { print($0["kCGWindowOwnerName"] as! String) }
        
        return visibleWindows
    }
    
    func getAllVisibleWindowNameList() -> [String] {
        let visibleWindows = getAllVisibleWindowInfoList()
        var windowNameList: [String] = []
        visibleWindows.forEach {
            if windowNameList.contains($0["kCGWindowOwnerName"] as! String) == false {
                windowNameList.append($0["kCGWindowOwnerName"] as! String)
            }
        }
        
        return windowNameList
    }
    
}
