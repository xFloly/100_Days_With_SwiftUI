
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    

    var calculatedBedtime: String {
        var alertMessage = ""
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }

        return alertMessage
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                
                //Challange 1
//                Section("When do you want to wake up?"){
//                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
//                        .labelsHidden()
//                }.font(.headline)
//                
//                Section("Desired amount of sleep"){
//                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
//                }.font(.headline)
//                
//                Section("Daily caffee intake"){
//                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
//                }.font(.headline)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }

                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep")
                        .font(.headline)

                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }

                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    //Challange 2
                    Picker("amount of cups", selection: $coffeeAmount){
                        ForEach(1...20, id:\.self){
                            Text("^[\($0) cup](inflect: true)")
                        }
                    }
                    //Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                }
                Section{
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Recommended bed time")
                            .font(.headline)
                        Text(calculatedBedtime)
                        //.foregroundStyle(ccb <= sleepAmount ? .red : .black)
                    }
                }
            }
            .navigationTitle("BetterRest")
        }
    }

    func calculateBedtime() -> String {
        var alertMessage = ""
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {

            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }

        return alertMessage
    }
}

#Preview {
    ContentView()
}
