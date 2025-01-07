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
    
    var start : Date?
    
    private var _start : Date {
        return start ?? now
    }
    
    @State private var todayDateTime : Date = Date()
    @State private var tomorrowDateTime : Date = Date()
    
    private var selectedTodayDateTime : Binding<Date> {
        Binding {
            if !cal.isDateInTomorrow(_start) {
                return _start
            }
            
            if cal.isDateInTomorrow(dateTime) {
                return todayPickerDateRange.lowerBound
            }
            
            return _start > dateTime ? _start : dateTime
        }
        set: { newDate in
            todayDateTime = newDate
        }
    }
    private var selectedTomorrowDateTime : Binding<Date> {
        Binding {
            if cal.isDateInTomorrow(_start) {
                return _start > dateTime ? _start : dateTime
            }
            if cal.isDateInTomorrow(dateTime) {
                return dateTime
            }
            return tomorrowPickerDateRange.lowerBound
        }
        set: { newDate in
            tomorrowDateTime = newDate
        }
    }
    
    @State private var day = Day.today
    @State private var now = Date()
    @State private var cal = Calendar.current
    
    @State private var isTodayDisabled = false
    
    var todayPickerDateRange : ClosedRange<Date> {
        let periodStart = _start
        let periodEnd = cal.startOfDay(for: periodStart.addingTimeInterval(.day))
            .addingTimeInterval(-.minute)
        
        return periodStart...periodEnd
    }
    
    var tomorrowPickerDateRange : ClosedRange<Date> {
        let periodStart = cal.isDateInTomorrow(_start)
            ? _start
            : cal.startOfDay(for: _start.addingTimeInterval(.day))
        let periodEnd = cal.isDateInTomorrow(_start)
        ? todayPickerDateRange.upperBound
        : _start.addingTimeInterval(.day - .minute)
        
        return periodStart...periodEnd
    }
    
    var body: some View {
        VStack {
            if !isTodayDisabled {
                Picker("Day", selection: $day) {
                    Text("Today").tag(Day.today)
                    Text("Tomorrow").tag(Day.tomorrow)
                }
                #if os(watchOS)
                .labelsHidden()
                #endif
                #if os(iOS)
                .pickerStyle(.wheel)
                #endif
            }
    
            HStack {
                switch day {
                case .today:
                    DatePicker("End Time",
                               selection: selectedTodayDateTime,
                               in: todayPickerDateRange,
                               displayedComponents: [.hourAndMinute])
                    .datePickerStyle(.wheel)
                case .tomorrow:
                    DatePicker("End Time",
                               selection: selectedTomorrowDateTime,
                               in: tomorrowPickerDateRange,
                               displayedComponents: [.hourAndMinute])
                    .datePickerStyle(.wheel)
                }
                
            }
            .labelsHidden()
            
            #if os(iOS)
            Spacer()
            #endif
            
            Button {
                dateTime = day == .today ? todayDateTime : tomorrowDateTime
                dismiss()
            } label: {
                Text("Save")
            }
            #if os(iOS)
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle)
            .padding()
            .font(.title2)
            #endif
        }
        .task {
            if cal.isDateInTomorrow(_start) {
                isTodayDisabled = true
                day = .tomorrow
            } else {
                isTodayDisabled = false
                if cal.isDateInTomorrow(dateTime) {
                    day = .tomorrow
                }
                else {
                    day = .today
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var dateTime = Date()
    EndTimePicker(dateTime: $dateTime, start: dateTime.addingTimeInterval(.minute))
}
