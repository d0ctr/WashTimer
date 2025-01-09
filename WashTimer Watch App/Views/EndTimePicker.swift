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
    
    private var start : Date
    
    @State private var todayDateTime : Date
    @State private var tomorrowDateTime : Date
    
    @State private var day : Day = .today
    @State private var isTodayDisabled : Bool
    
    private var todayPickerDateRange : ClosedRange<Date>
    private var tomorrowPickerDateRange : ClosedRange<Date>
    
    init(_ dateTime: Binding<Date>, start: Date = .now) {
        self.start = start
        _dateTime = dateTime
        
        let cal = Calendar.current
        
        let endOfToday = cal.startOfDay(for: start.addingTimeInterval(.day)).addingTimeInterval(-.minute)
        todayPickerDateRange = start...endOfToday
        
        let maxStart = max(start, dateTime.wrappedValue)
        
        if cal.isDateInTomorrow(start) {
            isTodayDisabled = true
            tomorrowPickerDateRange = start...endOfToday
            todayDateTime = Date()
            tomorrowDateTime = maxStart
        } else {
            isTodayDisabled = false
            tomorrowPickerDateRange =
                cal.startOfDay(for: start.addingTimeInterval(.day))
                ...
                start.addingTimeInterval(.day - .minute)
            

            if cal.isDateInTomorrow(dateTime.wrappedValue) {
                todayDateTime = todayPickerDateRange.lowerBound
                tomorrowDateTime = dateTime.wrappedValue
            } else {
                todayDateTime = maxStart
                tomorrowDateTime = tomorrowPickerDateRange.lowerBound
            }
        }
    }
    
    init(_ dateTime: Binding<Date>, todayPickerDateRange: ClosedRange<Date>?, tomorrowPickerDateRange: ClosedRange<Date>?) {
        self.init(dateTime)
        if todayPickerDateRange != nil {
            self.todayPickerDateRange = todayPickerDateRange!
        }
        if tomorrowPickerDateRange != nil {
            self.tomorrowPickerDateRange = tomorrowPickerDateRange!
        }
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
                               selection: $todayDateTime,
                               in: todayPickerDateRange,
                               displayedComponents: [.hourAndMinute])
                    .datePickerStyle(.wheel)
                case .tomorrow:
                    DatePicker("End Time",
                               selection: $tomorrowDateTime,
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
        .onAppear {
            let cal = Calendar.current
            if cal.isDateInTomorrow(start) {
                isTodayDisabled = true
                day = .tomorrow
            } else {
                isTodayDisabled = false
                if cal.isDateInTomorrow(dateTime) {
                    day = .tomorrow
                } else {
                    day = .today
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var dateTime = Date()
    EndTimePicker($dateTime, start: dateTime.addingTimeInterval(.minute))
}
