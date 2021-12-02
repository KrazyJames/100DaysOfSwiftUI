//
//  ContentView.swift
//  BetterRest
//
//  Created by jescobar on 11/30/21.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUpTime = defaultWakeUpTime
    @State private var sleepHours = 8.0
    @State private var coffeeCupsSelection = 0
    private var coffeeCups: Int {
        coffeeCupsSelection + 1
    }

    static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    private var amountCoffee: String {
        coffeeCups == 1 ? "1 cup" : "\(coffeeCups) cups"
    }

    private var bedtime: String {
        calculateSleep()
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Wake up time", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                }

                Section {
                    Stepper("\(sleepHours.formatted()) hours", value: $sleepHours, in: 4...12, step: 0.25)
                } header: {
                    Text("Desired amount of sleep")
                }

                Section {
                    Picker(amountCoffee, selection: $coffeeCupsSelection) {
                        ForEach(1..<13) { cups in
                            Text("\(cups)")
                        }
                    }
                } header: {
                    Text("Daily coffee intake")
                }

                Section {
                    Text(bedtime)
                } header: {
                    Text("Bedtime")
                }
            }
            .navigationTitle("BetterRest")
        }
    }

    private func calculateSleep() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            let hours = (components.hour ?? 0) * 60 * 60
            let minutes = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hours + minutes), estimatedSleep: sleepHours, coffee: Double(coffeeCups))
            let bedtime = wakeUpTime - prediction.actualSleep
            return bedtime.formatted(date: .omitted, time: .shortened)
        } catch {
            debugPrint(error.localizedDescription)
            return "Something went wrong!"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
