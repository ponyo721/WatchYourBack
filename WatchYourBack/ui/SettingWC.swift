//
//  SettingWC.swift
//  CustomScreenSaver
//
//  Created by byeongho park on 11/25/24.
//

import Cocoa

protocol SettingWCDelegate: AnyObject {
    func actionSetScreenSaverInfo(_ isOnScreenSaver: Bool?, _ isMouseTracking: Bool?, _ isKeyboardTracking: Bool?, _ screenSaverTime: TimeInterval?)
    func settingWindowClosed()
}

class SettingWC: NSWindowController, NSWindowDelegate {
    var settingVC: SettingVC?
    var delegate : SettingWCDelegate?
    var dataSource: [SettingVCItem]?
    
    // @IBOutlet
    @IBOutlet weak var customView: NSView!
    @IBOutlet weak var saveBtn: NSButton!
    @IBOutlet weak var mouseDetectCheckBox: NSButton!
    @IBOutlet weak var keyboardDetectCheckBox: NSButton!
    @IBOutlet weak var screenSaverTimePicker: NSDatePicker!
    @IBOutlet weak var screenSaverSwitch: NSSwitch!
    
    override var windowNibName: NSNib.Name? {
        NSNib.Name("SettingWC")
    }

    override func windowDidLoad() {
        print("[SettingWC] windowDidLoad")
        super.windowDidLoad()

        initalizeUI()
    }
    
    func initalizeUI() {
        print("[SettingWC] initalizeUI")
        
        settingVC = SettingVC(nibName: SettingVC.className(), bundle: nil)
        settingVC?.dataSource = dataSource
        settingVC?.view.frame = customView.frame
        window!.contentView!.addSubview(settingVC!.view)
        
        saveBtn.title = "Save"
        saveBtn.becomeFirstResponder()
    }
    
    //MARK: - ui action -
    @IBAction func saveBtnClicked(_ sender: Any) {
        print("mouseDetectCheckBox state: \(mouseDetectCheckBox.state)")
        print("keyboardDetectCheckBox state: \(keyboardDetectCheckBox.state)")
        print("screenSaverTimePicker value: \(screenSaverTimePicker.dateValue)")
        
        print("screenSaverSwitch state: \(screenSaverSwitch.state)")
        
        print("timeIntervalSince1970 value: \(screenSaverTimePicker.dateValue.timeIntervalSince(screenSaverTimePicker.minDate!))")
    }
    
    @IBAction func actionScreenSaverSwitch(_ sender: Any) {
        if screenSaverSwitch.state == .on {
            print("mouseDetectCheckBox state: \(mouseDetectCheckBox.state)")
            print("keyboardDetectCheckBox state: \(keyboardDetectCheckBox.state)")
            
            print("screenSaverTimePicker value: \(screenSaverTimePicker.dateValue)")
            
        } else {
            print("mouseDetectCheckBox state: \(mouseDetectCheckBox.state)")
            print("keyboardDetectCheckBox state: \(keyboardDetectCheckBox.state)")
            
            print("screenSaverTimePicker value: \(screenSaverTimePicker.dateValue)")
        }
    }
    //MARK: - NSWindowDelegate -
    func windowWillClose(_ notification: Notification) {
        print("[SettingWC] windowWillClose")
        
        delegate?.settingWindowClosed()
    }
}
