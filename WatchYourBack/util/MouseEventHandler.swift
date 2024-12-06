//
//  MouseEventHandler.swift
//  CustomScreenSaver
//
//  Created by byeongho park on 12/4/24.
//

import Foundation
import AppKit

class MouseEventHandler {
    
    private var localMonitor: AnyObject?
    private var globalMonitor: AnyObject?
    
    private let mask: NSEvent.EventTypeMask
    private let globalHandler: (NSEvent?) -> Void
    private let localHandler: (NSEvent) -> NSEvent?
    
    public init(mask: NSEvent.EventTypeMask, globalHandler: @escaping (NSEvent?) -> Void, localHandler: @escaping (NSEvent) -> NSEvent?) {
        self.mask = mask
        self.globalHandler = globalHandler
        self.localHandler = localHandler
    }
    
    deinit {
        stop()
    }
    
    public func start() {
        globalMonitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: globalHandler) as AnyObject?
        localMonitor = NSEvent.addLocalMonitorForEvents(matching: mask, handler: localHandler) as AnyObject?
    }
    
    public func stop() {
        if globalMonitor != nil {
            NSEvent.removeMonitor(globalMonitor!)
            globalMonitor = nil
        }
        
        if localMonitor != nil {
            NSEvent.removeMonitor(localMonitor!)
            localMonitor = nil
        }
    }
    
    
//    func startLocalEventMonitoring() {
//        
//    }
//    
//    func startGlobalEventMonitoring() {
//        
//        
//    }
}
