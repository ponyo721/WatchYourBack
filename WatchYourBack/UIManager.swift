//
//  UIManager.swift
//  CustomScreenSaver
//
//  Created by byeongho park on 11/25/24.
//

import Foundation
import AppKit

protocol UIManagerDelegate: AnyObject {
    func terminateApplication()
    func getCurrentVisibleWindowScreenSaverInfoList(completion: @escaping (_ list:[ApplicationScreenSaverInfo]?)->Void)
}

class UIManager: SettingWCDelegate{
    var mainWC : SettingWC? = nil
    var delegate: UIManagerDelegate?
    var statusItem: NSStatusItem?
    
    func initailize() {
        showTrayIcon()
    }
    
    func showTrayIcon() {
        print("[UIManager] showTrayIcon")
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "star.fill", accessibilityDescription: "Tray Icon")
            button.image?.isTemplate = true
        }
        
        let menu = NSMenu()
        let menuItem1 = NSMenuItem(title: "Show Settings", action: #selector(showMainWindow), keyEquivalent: "")
        menuItem1.target = self
        menu.addItem(menuItem1)
        
        menu.addItem(NSMenuItem.separator())
        
        let menuItem2 = NSMenuItem(title: "terminate", action: #selector(actionTerminateBtn), keyEquivalent: "")
        menuItem2.target = self
        menu.addItem(menuItem2)
        
        statusItem?.menu = menu
    }
    
    //MARK: - tray action -
    @objc func showMainWindow() {
        print("[UIManager] showMainWindow")
        
        delegate?.getCurrentVisibleWindowScreenSaverInfoList { list in
            if self.mainWC == nil {
                print("window nil & create new")
                self.mainWC = SettingWC(windowNibName: SettingWC.className())
            } else {
                print("already show window")
                return
            }
            
            if list != nil {
                var settingVCItems: [SettingVCItem] = []
                for info in list! {
                    settingVCItems.append(SettingVCItem(applicationName: info.applicationName, applicationScreenSaverState: false))
                }
                self.mainWC?.dataSource = settingVCItems
            }
            
            self.mainWC?.window?.title = "Setting"
            self.mainWC?.window?.level = .modalPanel
            self.mainWC?.delegate = self
            self.mainWC?.showWindow(self)
        }
    }
    
    @objc func actionTerminateBtn() {
        delegate?.terminateApplication()
    }
    
    //MARK: - SettingWCDelegate -
    func settingWindowClosed() {
        print("mainWC nil")
        mainWC = nil
    }
    
    func actionSetScreenSaverInfo(_ isOnScreenSaver: Bool?, _ isMouseTracking: Bool?, _ isKeyboardTracking: Bool?, _ screenSaverTime: TimeInterval?) {
        
    }
    
}
