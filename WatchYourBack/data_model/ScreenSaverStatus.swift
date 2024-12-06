//
//  ScreenSaverStatus.swift
//  CustomScreenSaver
//
//  Created by byeongho park on 11/26/24.
//

import Cocoa

struct ApplicationScreenSaverInfo {
    var applicationName : String = ""
    var applicationIconImage : NSImage?
    
    var isScreenSaverOn : Bool = false
}

struct ScreenSaverInfo {
    var isOnScreenSaver : Bool = false
    
    var applicationInfoList : [ApplicationScreenSaverInfo] = []
    
    var isMouseTracking : Bool = false
    var isKeyboardTracking : Bool = false
    var screenSaverTimeout : TimeInterval = 0
}
