//
//  Cronometro.swift
//  Relogio
//
//  Created by aluno on 22/04/21.
//  Copyright © 2021 Cesar School. All rights reserved.
//

import Foundation

class Cronometro: NSObject {
    
    var startTime = TimeInterval(0)
    var accumulatedTime = TimeInterval(0)
    var elapsedSinceLastRefresh = TimeInterval(0)
    var timer = Timer()
    
    var elapsedTime: TimeInterval {
        return elapsedSinceLastRefresh + accumulatedTime
    }
    
    var refreshInterval = TimeInterval(1)
    var timeLimit: TimeInterval?
    var updateBlock: ((TimeInterval, TimeInterval?) -> ())?
    var completedBlock: (() -> ())?
    
    
    
    convenience init(refreshInterval: TimeInterval) {
        self.init()
        self.refreshInterval = refreshInterval
    }
    
    convenience init(refreshInterval: TimeInterval, updateBlock: @escaping (TimeInterval, TimeInterval?) -> ()) {
        self.init()
        self.refreshInterval = refreshInterval
        self.updateBlock = updateBlock
    }
    
    
    func refreshTime() {
        let refreshTime = Date.timeIntervalSinceReferenceDate
        
        self.elapsedSinceLastRefresh = (refreshTime - startTime)
        
        var remainingTime: TimeInterval? = nil
        
        if self.timeLimit != nil {
            remainingTime = self.timeLimit! - elapsedTime
        }
        
        self.updateBlock?(elapsedTime, remainingTime)
        
        if let limit = self.timeLimit {
            if self.elapsedTime >= limit {
                self.stop()
                self.completedBlock?()
            }
        }
    }
    
    
    func setLimit(timeLimit: TimeInterval, withCompletionBlock completedBlock: @escaping () -> ()) {
        
        self.timeLimit = timeLimit
        self.completedBlock = completedBlock
    }
    
    func start() {
        if !timer.isValid {
            timer = Timer.scheduledTimer(timeInterval: refreshInterval, target: self, selector: Selector(("refreshTime")), userInfo: nil, repeats: true)
            
            startTime = Date.timeIntervalSinceReferenceDate
        }
    }
    
    func stop() {
        timer.invalidate()
        accumulatedTime = elapsedTime
        elapsedSinceLastRefresh = 0
    }
    
}
