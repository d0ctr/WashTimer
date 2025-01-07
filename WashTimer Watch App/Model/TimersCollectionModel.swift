//
//  TimersCollectionModel.swift
//  WashTimer
//
//  Created by Danila Vasilev on 1/6/25.
//

import Foundation
import SwiftData

@Model
class TimersCollectionModel {
    var timers : [TimerModel] = []
    
    init() {
        self.timers.append(.defaultTimer)
    }

}
