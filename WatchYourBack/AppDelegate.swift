//
//  AppDelegate.swift
//  CustomScreenSaver
//
//  Created by byeongho park on 11/25/24.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    let screenSaverManager: ScreenSaverManager = ScreenSaverManager()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // check Accessability permission
        NSLog("[CustomScreenSaver] applicationDidFinishLaunching")
        if AXIsProcessTrusted() {
            NSLog("AXIsProcessTrusted ON")
        }else {
            NSLog("AXIsProcessTrusted OFF")
        }
        
        screenSaverManager.initailize()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

