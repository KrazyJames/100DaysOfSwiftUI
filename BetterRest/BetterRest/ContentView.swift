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
    @State private var coffeeCups = 1

    static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    private var amountCoffee: String {
        coffeeCups == 1 ? "1 cup" : "\(coffeeCups) cups"
    }

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isAlertPresented = false

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
                    Stepper(amountCoffee, value: $coffeeCups, in: 1...12)
                } header: {
                    Text("Daily coffee intake")
                }
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateSleep)
            }
            .alert(alertTitle, isPresented: $isAlertPresented) {
                Button("Ok") { }
            } message: {
                Text(alertMessage)
            }
        }
    }

    private func calculateSleep() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            let hours = (components.hour ?? 0) * 60 * 60
            let minutes = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hours + minutes), estimatedSleep: sleepHours, coffee: Double(coffeeCups))
            let bedtime = wakeUpTime - prediction.actualSleep
            alertTitle = "Your bedtime"
            alertMessage = bedtime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Something went wrong!"
            debugPrint(error.localizedDescription)
        }
        isAlertPresented.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
