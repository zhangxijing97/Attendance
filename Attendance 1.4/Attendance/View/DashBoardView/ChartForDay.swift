//
//  ChartForDay.swift
//  Attendance
//
//  Created by 张熙景 on 3/19/23.
//

import SwiftUI
import Charts

struct Product: Identifiable {
    let id = UUID()
    let category: Int
    let numberOfSell: Int
    let season: String
    let profit: Double
}

struct ChartForDay: View {
    var allSeasonProducts: [Product] = [
        .init(category: 1, numberOfSell: 3, season: "summer", profit: 220),
        .init(category: 2, numberOfSell: 4, season: "winter", profit: 240),
        .init(category: 3, numberOfSell: 12, season: "spring", profit: 1400),
        .init(category: 4, numberOfSell: 14, season: "summer", profit: 1100),
        .init(category: 5, numberOfSell: 10, season: "spring", profit: 2100),
        .init(category: 8, numberOfSell: 14, season: "summer", profit: 1800),
        .init(category: 9, numberOfSell: 16, season: "summer", profit: 1900),
        .init(category: 11, numberOfSell: 12, season: "spring", profit: 1800),
        .init(category: 15, numberOfSell: 9, season: "winter", profit: 900)
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Products Overview")
            Chart(allSeasonProducts) {
                BarMark(
                    x: .value("Season", $0.season),
                    y: .value("Profit", $0.profit)
                )
            }
        }
        .frame(width: 554)
        .padding(28)
    }
}

struct ChartForDay_Previews: PreviewProvider {
    static var previews: some View {
        ChartForDay()
    }
}
