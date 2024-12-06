//
//  TimerUtil.swift
//  CustomScreenSaver
//
//  Created by byeongho park on 12/4/24.
//

import Foundation

protocol TimerUtilDelegate {
    func onTimer(_ timerKey:String)
}

class TimerUtil {
    var delegate: TimerUtilDelegate?
    
    private var timerList: [String:Timer] = [:]
    
    func addTimerWithKey(_ key:String, interval:TimeInterval){
        guard timerList[key] == nil else {
            print("\(key) timer already exists.")
            return
        }
        
        print("addTimerWithKey : \(key)")
        
        let newTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: {[weak self] _ in
            self?.onTimer(key)
        })
        
        timerList.updateValue(newTimer, forKey: key)
    }
    
    func removeTimerWithKey(_ key:String) {
        print("removeTimerWithKey : \(key)")
        
        if let tiemr:Timer = timerList[key] {
            print("tiemr.invalidate : \(key)")
            tiemr.invalidate()
            timerList.removeValue(forKey: key)
        }
    }
    
    func onTimer(_ key:String){
        print("onTimer : \(key)")
        
        delegate?.onTimer(key)
    }
}
