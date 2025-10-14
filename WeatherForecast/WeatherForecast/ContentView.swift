//
//  ContentView.swift
//  WeatherForecast
//
//  Created by Nil Silva on 29/09/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DailyForecastView()
            WeeklySummaryView()
            
            
        }
    }
}

#Preview {
    ContentView()
}

enum WeatherType{
    case sunny, rainy, cloudy
}


struct DailyForecastView: View {
    var body: some View {
        
        VStack{
            HStack{
                
                DayWeather(day: "Mon", weather: .sunny, high: 30, low: 25)
                DayWeather(day: "Tue", weather: .rainy, high: 20, low: 10)
                DayWeather(day: "Wed", weather: .cloudy, high: 22, low: 18)
            }
            
            HStack{
                DayWeather(day: "Thu", weather: .cloudy, high: 20, low: 15)
                DayWeather(day: "Fri", weather: .sunny, high: 23, low: 17)
                DayWeather(day: "Sat", weather: .rainy, high: 18, low: 13)
            }
        }
    }
}


struct WeeklySummaryView: View {
    let highs = [30, 20, 22, 20, 23, 18]
    let lows = [25, 10, 18, 15, 17, 13]
    
    var averageHigh: Int {
        highs.reduce(0, +) / highs.count
    }
    
    var averageLow: Int {
        lows.reduce(0, +) / lows.count
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Weekly Summary")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Average High: \(averageHigh)°C")
                
                .font(.title2)
                .foregroundStyle(.red)
            
            Text("Average Low: \(averageLow)°C")
                .font(.title2)
                .foregroundStyle(.blue)
        }
        .padding()
    }
}


struct DayWeather: View {
    let day: String
    let weather: WeatherType
    let high: Int
    let low: Int
    
    private var weatherData: (icon: String, color: Color) {
        
        switch weather {
        case .sunny: return ("sun.max.fill", .yellow)
        case .rainy: return ("cloud.heavyrain.fill", .blue)
        case .cloudy: return ("cloud.fill",.gray)
        }
    }
    
    
    var body: some View {
        VStack {
            
            Text(day)
                .font(Font.headline)
            
            Image(systemName: weatherData.icon)
                .foregroundStyle(weatherData.color)
                .font(Font.largeTitle)
                .padding(5)
            
            Text("High: \(high)")
                .fontWeight(.semibold)
            
            Text("Low: \(low)")
                .fontWeight(.medium)
                .foregroundStyle(Color.secondary)
        }
        .padding()
    }
    
}
