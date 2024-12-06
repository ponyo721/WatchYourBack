//
//  CustomCheckBox.swift
//  CustomScreenSaver
//
//  Created by byeongho park on 12/4/24.
//

import Cocoa

protocol CustomCheckBoxDelegate {
    func actionCheckBoxBtn(_ isOn:Bool, btnNum:Int?)
}

class CustomCheckBox: NSViewController {
    var delegate: CustomCheckBoxDelegate?
    
    var isOn: Bool = false
    var btnNum: Int = 0
    
    @IBOutlet weak var checkBoxBtn: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        checkBoxBtn.title = "Screen Saver ON"
        if isOn {
            checkBoxBtn.state = .on
        } else {
            checkBoxBtn.state = .off
        }
    }
    
    @IBAction func actionCustomCheckBoxBtn(_ sender: Any) {
        print("[CustomCheckBox] actionCustomCheckBoxBtn")
        delegate?.actionCheckBoxBtn(checkBoxBtn.state == .on ? true:false, btnNum: btnNum)
    }
}
