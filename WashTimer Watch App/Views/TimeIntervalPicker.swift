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
    
    @State private var date = Date()
    private var selectedDate : Binding<Date> {
        Binding {
            return startOfToday.addingTimeInterval(self.timeInterval)
        }
        set: { newDate in
            self.date = newDate
        }
    }
    private let startOfToday = Calendar.current.startOfDay(for: .now)
    
    init(timeInterval: Binding<TimeInterval>) {
        self._timeInterval = timeInterval
    }
    
    var body: some View {
        VStack {
            DatePicker("time", selection: selectedDate, displayedComponents: [.hourAndMinute])
                .labelsHidden()
            #if os(iOS)
                .datePickerStyle(.wheel)
            #endif
            
            #if os(iOS)
            Spacer()
            #endif
            
            Button("Save") {
                timeInterval = startOfToday.distance(to: date)
                dismiss()
            }
            #if os(iOS)
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle)
            .padding()
            .font(.title2)
            #endif
            
            #if os(iOS)
            Spacer()
            #endif
        }
    }
}

#Preview {
    @Previewable @State var timeInterval : TimeInterval = .hour + 2 * .minute
    TimeIntervalPicker(timeInterval: $timeInterval)
}
