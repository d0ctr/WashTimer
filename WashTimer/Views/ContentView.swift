//
//  ContentView.swift
//  WashTimer
//
//  Created by Danila Vasilev on 1/6/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var timers : [TimerModel]
    
    var body: some View {
        NavigationView {
            if let timer = timers.first {
                TimerView(timer: timer)
            }
        }
        .task {
            context.insert(TimerModel.defaultTimer)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: TimerModel.self, inMemory: true)
}
