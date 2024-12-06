//
//  ScreenSaverManager.swift
//  CustomScreenSaver
//
//  Created by byeongho park on 11/25/24.
//

import Cocoa

class ScreenSaverManager : UIManagerDelegate, SystemEventHandlerDelegate {
    let uiManager: UIManager = UIManager()
    let systemEventHandler: SystemEventHandler = SystemEventHandler()
    
    let sysWindowUtils: SysWindowManager = SysWindowManager()
    var screenSaverData: ScreenSaverInfo = ScreenSaverInfo()
    
    var currentWindowInfoList : [[String : Any]]?
    
    
    func initailize() {
        print("[ScreenSaverManager] initailize")
        currentWindowInfoList = sysWindowUtils.getAllVisibleWindowInfoList()
        initailizeScreenSaverData()
        
        uiManager.delegate = self
        uiManager.initailize()
        
        systemEventHandler.delegate = self
        systemEventHandler.initailize()
    }
    
    func initailizeScreenSaverData() {
        let allWindowNameList : [String] = sysWindowUtils.getAllVisibleWindowNameList()
        
        var applicationInfoList : [ApplicationScreenSaverInfo] = []
        for name in allWindowNameList {
            applicationInfoList.append(ApplicationScreenSaverInfo(applicationName: name))
        }
        
        screenSaverData.applicationInfoList = applicationInfoList
    }
 
    //MARK: - UIManagerDelegate -
    func terminateApplication() {
        print("[ScreenSaverManager] terminateApplication")
        NSApp.terminate(self)
    }
    
    func getCurrentVisibleWindowScreenSaverInfoList(completion: @escaping (_ list:[ApplicationScreenSaverInfo]?)->Void) {
        print("[ScreenSaverManager] getCurrentVisibleWindowScreenSaverInfoList")
        
        completion(screenSaverData.applicationInfoList)
    }
}
