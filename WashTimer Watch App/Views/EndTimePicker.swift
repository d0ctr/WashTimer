//
//  EndTimePicker.swift
//  WashTimer Watch App
//
//  Created by Danila Vasilev on 1/6/25.
//

import SwiftUI

struct EndTimePicker: View {
    @Environment(\.dismiss) var dismiss
    @Binding var dateTime : Date
    
    @State var start : Date?
    
    @State private var selectedTodayDateTime : Date = Date()
    @State private var selectedTomorrowDateTime : Date = Calendar.current.startOfDay(for: .now.addingTimeInterval(24 * 60 * 60))
    
    @State private var day = 0
    @State private var now = Date()
    @State private var cal = Calendar.current
    
    var todayPickerDateRange : ClosedRange<Date> {
        let start = self.start ?? now
        let end = cal.startOfDay(for: start.addingTimeInterval(24 * 60 * 60))
            .addingTimeInterval(-60)
        
        return start...end
    }
    
    var tomorrowPickerDateRange : ClosedRange<Date> {
        let start = cal.startOfDay(for: now.addingTimeInterval(24 * 60 * 60))
        let end = (self.start ?? now).addingTimeInterval(24 * 60 * 60).addingTimeInterval(-60)
        
        return start...end
    }
    
    var body: some View {
        VStack {
            Picker("Day", selection: $day) {
                Text("Today").tag(0)
                Text("Tomorrow").tag(1)
            }
            .labelsHidden()
    
            HStack {
                if day == 0 {
                    DatePicker("End Time",
                               selection: $selectedTodayDateTime,
                               in: todayPickerDateRange,
                        displayedComponents: [.hourAndMinute])
                } else {
                    DatePicker("End Time",
                               selection: $selectedTomorrowDateTime,
                               in: tomorrowPickerDateRange,
                               displayedComponents: [.hourAndMinute])
                }
                
            }
            .labelsHidden()
            Button {
                dateTime = day == 0 ? selectedTodayDateTime : selectedTomorrowDateTime
                dismiss()
            } label: {
                Text("Save")
            }
        }
    }
}

#Preview {
    @Previewable @State var dateTime = Date()
    EndTimePicker(dateTime: $dateTime)
}
