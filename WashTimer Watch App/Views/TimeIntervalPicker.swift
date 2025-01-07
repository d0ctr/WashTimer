//
//  TimeIntervalPicker.swift
//  WashTimer Watch App
//
//  Created by Danila Vasilev on 1/5/25.
//

import SwiftUI


struct TimeIntervalPicker: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var timeInterval : TimeInterval
    
    @State private var hours : Int = 0
    @State private var minutes : Int = 0
    
    var body: some View {
        VStack {
            HStack {
                Picker("Hours", selection: $hours) {
                    ForEach(0..<24) { i in
                        Text("\(i)").tag(i)
                    }
                }
                
                Picker("Minutes", selection: $minutes) {
                    ForEach(0..<60) { i in
                        Text("\(i)").tag(i)
                    }
                }
            }
            .pickerStyle(.wheel)
            .padding()
            
            Button("Save") {
                timeInterval = TimeInterval(hours * 3600 + minutes * 60)
                dismiss()
            }
        }
    }
}

#Preview {
    @Previewable @State var timeInterval = TimeInterval()
    TimeIntervalPicker(timeInterval: $timeInterval)
}
