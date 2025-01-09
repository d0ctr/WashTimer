//
//  TimerView.swift
//  WashTimer Watch App
//
//  Created by Danila Vasilev on 1/5/25.
//

import SwiftUI
import SwiftData

struct TimerView: View {
    @State var timer : TimerModel
    
    @State private var _delay = TimeInterval()
    @State private var _endTime = Date()
    
    private var delay : Binding<TimeInterval> {
        Binding {
            _delay
        }
        set: { d in
            _delay = d
            _endTime = .now.addingTimeInterval(timer.duration + d)
        }
    }
    private var endTime : Binding<Date> {
        Binding {
            _endTime
        }
        set: { t in
            _endTime = t
            _delay = Date.now.addingTimeInterval(timer.duration).distance(to: t)
        }
    }
    
    var body: some View {
        List {
            Section("Program Duration") {
                NavigationLink {
                    TimeIntervalPicker(timeInterval: $timer.duration)
                        .navigationTitle("Set Duration")
                } label: {
                    Text(timeInterval: timer.duration)
                        .font(.system(size: 24))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
            }

            Section("Delay") {
                NavigationLink {
                    TimeIntervalPicker(timeInterval: delay)
                        .navigationTitle("Set Delay")
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text(timeInterval: _delay)
                            .font(.system(size: 24))
                        Image(systemName: "plus")
                            .opacity(0)
                    }
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .center)
                }

            }

            Section {
                NavigationLink {
                    EndTimePicker(endTime, start: .now.addingTimeInterval(timer.duration))
                        .navigationTitle("Select End Time")
                } label: {
                    HStack {
                        Text(_endTime.formatted(date: .omitted, time: .shortened))
                            .font(.system(size: 24))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                }
            } header: {
                HStack {
                    Text("End Time")
                    if Calendar.current.isDateInTomorrow(_endTime) {
                        Text("Tomorrow")
                            .padding(.horizontal, 8)
                            .background(Color.accentColor)
                            .clipShape(.capsule(style: .circular))
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        .padding(.horizontal)
        .onAppear {
            _endTime = .now.addingTimeInterval(timer.duration + delay.wrappedValue)
        }
    }
}

#Preview {
    TimerView(timer: .defaultTimer)
}
