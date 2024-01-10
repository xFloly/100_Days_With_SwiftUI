//
//  TemperatureConversionView.swift
//  TemperatureConversionApp
//
//  Created by Student1 on 05/12/2023.
//

import SwiftUI

// TemperatureConversionView.swift
struct TemperatureConversionView: View {
    @State private var inputUnit = "Celsius"
    @State private var outputUnit = "Celsius"
    @State private var inputValue = ""

    let units = ["Celsius", "Fahrenheit", "Kelvin"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) { Text($0) }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    TextField("Enter value", text: $inputValue)
                        .keyboardType(.decimalPad)
                }

                Section {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) { Text($0) }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    Text("Result: \(convertTemperature())")
                }
            }
            .navigationTitle("Temperature Converter")
        }
    }

    func convertTemperature() -> String {
        let inputValue = Double(self.inputValue) ?? 0
        let convertedValue = TemperatureConverter.convert(value: inputValue, from: inputUnit, to: outputUnit)
        return String(format: "%.2f", convertedValue)
    }
}

#Preview {
    TemperatureConversionView()
}
