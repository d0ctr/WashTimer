//
//  TimerModel.swift
//  WashTimer
//
//  Created by Danila Vasilev on 1/6/25.
//

import Foundation
import SwiftData

let DEFAULT_TIMER_UUID = UUID(uuidString: "87e1e7ce-452b-4061-a7a8-2061b0a4c6e1")

@Model
class TimerModel: Identifiable {
    var id = UUID()
    var duration : TimeInterval
    var delay : TimeInterval
    var name : String
    
    init(name: String, duration: TimeInterval, delay: TimeInterval) {
        self.duration = duration
        self.delay = delay
        self.name = name
    }
    
    convenience init(id: UUID, name: String, duration: TimeInterval, delay: TimeInterval) {
        self.init(name: name, duration: duration, delay: delay)
        self.id = id
    }
    
    static var defaultTimer = TimerModel(id: DEFAULT_TIMER_UUID!, name: "Default", duration: TimeInterval(0), delay: TimeInterval(0))
}
