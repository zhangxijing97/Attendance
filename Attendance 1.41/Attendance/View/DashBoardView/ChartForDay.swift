//
//  ChartForDay.swift
//  Attendance
//
//  Created by 张熙景 on 3/19/23.
//

import SwiftUI
import Charts

struct ChartForDay: View {
    @ObservedObject var data: HTTPClient
    var session: String
    
    // Get selectedDate
    var selectedDate: Date {
        return data.selectedDate
    }

    var body: some View {
        VStack(alignment: .leading) {
            Chart(data.tracks) { track in
//                BarMark(
//                    x: .value("Tracks", track.name),
//                    y: .value("Number of Students", data.tracks.count)
//                )
//                .foregroundStyle(Color(red: 0.3294, green: 0.3647, blue: 0.9215))
                BarMark(
                    x: .value("Tracks", track.name),
                    y: .value("Number of Students (2nd Y-axis)", Int.random(in: 1...100))
                )
                .foregroundStyle(Color(red: 0.3294, green: 0.3647, blue: 0.9215))
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }

        }
        .padding(28)
    }
}

struct ChartForDay_Previews: PreviewProvider {
    static var previews: some View {
        ChartForDay(data: HTTPClient(), session: "")
    }
}
