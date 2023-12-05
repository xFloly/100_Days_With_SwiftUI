//
//  TemperatureConventer.swift
//  TemperatureConversionApp
//
//  Created by Student1 on 05/12/2023.
//

import Foundation
// TemperatureConverter.swift
struct TemperatureConverter {
    static func convert(value: Double, from inputUnit: String, to outputUnit: String) -> Double {
        let baseValue = convertToCelsius(value: value, from: inputUnit)
        return convertFromCelsius(value: baseValue, to: outputUnit)
    }

    private static func convertToCelsius(value: Double, from unit: String) -> Double {
        switch unit {
        case "Fahrenheit": return (value - 32) * 5 / 9
        case "Kelvin": return value - 273.15
        default: return value // Celsius
        }
    }

    private static func convertFromCelsius(value: Double, to unit: String) -> Double {
        switch unit {
        case "Fahrenheit": return (value * 9 / 5) + 32
        case "Kelvin": return value + 273.15
        default: return value // Celsius
        }
    }
}
