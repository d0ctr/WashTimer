//
//  Extension.swift
//  WashTimer
//
//  Created by Danila Vasilev on 1/5/25.
//
import SwiftUI

extension Text {
    init(timeInterval: TimeInterval) {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.zeroFormattingBehavior = .pad

        self.init(formatter.string(from: timeInterval)!)
    }
}

extension TimeInterval {
    static let    day : TimeInterval = 24 * 60 * 60
    static let   hour : TimeInterval = 60 * 60
    static let minute : TimeInterval = 60
}
