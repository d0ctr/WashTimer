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

    @State private var endTime = Date()
    @State private var now = Date()
    
    var body: some View {
        List {
            Section("Program Duration") {
                NavigationLink {
                    TimeIntervalPicker(timeInterval: $timer.duration)
                        .navigationTitle("Set Duration")
                        .onChange(of: timer.duration) {
                            now = Date()
                        }
                } label: {
                    Text(timeInterval: timer.duration)
                        .font(.system(size: 24))
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
            }

            Section("Delay") {
                NavigationLink {
                    TimeIntervalPicker(timeInterval: $timer.delay)
                        .navigationTitle("Set Delay")
                        .onChange(of: timer.delay) {
                            now = Date()
                            endTime = now.addingTimeInterval(timer.duration + timer.delay)
                        }
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text(timeInterval: timer.delay)
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
                    EndTimePicker(dateTime: $endTime, start: now.addingTimeInterval(timer.duration))
                        .navigationTitle("Select End Time")
                        .onChange(of: endTime) {
                            now = Date()
                            timer.delay = now.addingTimeInterval(timer.duration).distance(to: endTime)
                        }
                } label: {
                    HStack {
                        Text(endTime.formatted(date: .omitted, time: .shortened))
                            .font(.system(size: 24))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                }
            } header: {
                HStack {
                    Text("End Time")
                    if Calendar.current.isDateInTomorrow(endTime) {
                        Text("Tomorrow")
                            .padding(.horizontal)
                            .background(Color.accentColor)
                            .clipShape(.capsule(style: .circular))
                    }
                }
            }
        }
        .task {
            endTime = now.addingTimeInterval(timer.duration + timer.delay)
        }
    }
}

#Preview {
    TimerView(timer: .defaultTimer)
}
