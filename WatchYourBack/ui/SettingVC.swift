//
//  SettingVC.swift
//  CustomScreenSaver
//
//  Created by byeongho park on 11/25/24.
//

import Cocoa

struct SettingVCItem {
    var applicationName : String?
    var applicationScreenSaverState : Bool?
}

class SettingVC: NSViewController, NSTableViewDelegate, NSTableViewDataSource, CustomCheckBoxDelegate {
    public var dataSource: [SettingVCItem]?
    
    private var tableItems: [String : CustomCheckBox] = [:]
    
    @IBOutlet weak var applicationStatusTableView: NSTableView!
    
    override func viewDidLoad() {
        print("[SettingVC] viewDidLoad")
        super.viewDidLoad()
        
        applicationStatusTableView.delegate = self
        applicationStatusTableView.dataSource = self
    }
    
    //MARK: - NSTableViewDataSource -
    func numberOfRows(in tableView: NSTableView) -> Int {
        print("[SettingVC] numberOfRows \(dataSource?.count ?? 0)")
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        print("[SettingVC] tableView \(String(describing: tableColumn)) row: \(row)")
        
        let item :SettingVCItem? = dataSource?[row]
        
        if tableColumn?.identifier.rawValue == "appName" {
            let textView: NSTextView
            
            if let frame = tableColumn?.tableView?.rowView(atRow: row, makeIfNecessary: false)?.frame {
                textView = NSTextView(frame: frame)
            }else {
                textView = NSTextView(frame: NSMakeRect(0, 0, 20, 20))
            }
            textView.backgroundColor = .clear
            textView.string = item?.applicationName ?? ""
            
            return textView
        } else {    // check box
            let btnView: CustomCheckBox = CustomCheckBox(nibName: CustomCheckBox.className(), bundle: nil)
            btnView.delegate = self
            btnView.btnNum = row
            
            if let frame = tableColumn?.tableView?.rowView(atRow: row, makeIfNecessary: false)?.frame {
                btnView.view.frame = frame
            }else {
                btnView.view.frame = NSMakeRect(0, 0, 20, 20)
            }
            
            tableItems.updateValue(btnView, forKey: item?.applicationName ?? "")
            print("updateValue : \(tableItems)")
            
            btnView.isOn = item?.applicationScreenSaverState ?? false
            return btnView.view
        }
    }
    
    //MARK: - [SubView Event] CustomCheckBoxDelegate -
    
    func actionCheckBoxBtn(_ isOn:Bool, btnNum:Int?) {
        print("actionCheckBoxBtn isOn : \(isOn), btnNum : \(String(describing: btnNum))")
        
        print("appName : \(String(describing: dataSource?[btnNum ?? 0].applicationName)), isOn : \(isOn)")
    }
}
