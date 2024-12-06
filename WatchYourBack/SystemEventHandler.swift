//
//  SystemEventHandler.swift
//  CustomScreenSaver
//
//  Created by byeongho park on 12/4/24.
//

import Foundation
import AppKit

protocol SystemEventHandlerDelegate {
    
}

class SystemEventHandler {
    public var delegate: SystemEventHandlerDelegate?
    
    private var mouseEventHandler : MouseEventHandler?
    private var mouseGlobalCount : Int = 0
    private var mouseLocalCount : Int = 0
    
    private var keyboardEventHandler : KeyboardEventHandler?
    private var keyboardGlobalCount : Int = 0
    private var keyboardLocalCount : Int = 0
    
    func initailize() {
        startMouseEventMonitoring()
        startKeyboardEventMonitoring()
    }
    
    //MARK: - B/L Private -
    func startMouseEventMonitoring() {
        mouseEventHandler = MouseEventHandler(mask: NSEvent.EventTypeMask.mouseMoved, globalHandler: { (mouseEvent: NSEvent?) in
            self.mouseGlobalCount += 1
//            print("global mouse event monitor: \(self.mouseGlobalCount)")
        }, localHandler: { (mouseEvent: NSEvent) in
            self.mouseLocalCount += 1
//            print("local mouse event monitor: \(self.mouseLocalCount)")
            return mouseEvent
        })
        mouseEventHandler?.start()
    }
    
    func startKeyboardEventMonitoring() {
        keyboardEventHandler = KeyboardEventHandler(mask: NSEvent.EventTypeMask.keyDown, globalHandler: { (mouseEvent: NSEvent?) in
            self.keyboardGlobalCount += 1
//            print("global keyboard event monitor: \(self.keyboardGlobalCount)")
        }, localHandler: { (mouseEvent: NSEvent) in
            self.keyboardLocalCount += 1
//            print("local keyboard event monitor: \(self.keyboardLocalCount)")
            return mouseEvent
        })
        keyboardEventHandler?.start()
    }
}
