//
//  WashTimerApp.swift
//  WashTimer Watch App
//
//  Created by Danila Vasilev on 1/5/25.
//

import SwiftUI
import SwiftData

@main
struct WashTimer_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [TimersCollectionModel.self, TimerModel.self])
        }
    }
}
