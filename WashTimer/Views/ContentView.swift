//
//  ContentView.swift
//  WashTimer
//
//  Created by Danila Vasilev on 1/6/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TimerView(timer: .defaultTimer)
        }
    }
}

#Preview {
    ContentView()
}
