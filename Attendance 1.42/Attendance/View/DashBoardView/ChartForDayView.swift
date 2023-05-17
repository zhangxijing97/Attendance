//
//  ChartForDayView.swift
//  Attendance
//
//  Created by 张熙景 on 3/18/23.
//

import SwiftUI

struct ChartForDayView: View {
    @ObservedObject var data: HTTPClient
    
    @State private var selectedDate = Date()
    @State private var session = "0"
    let sessions = ["0", "1"]
    
    var startOfWeek = Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 12))!
    var endOfWeek = Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 30))!
    @State private var isDetailViewShown = false

    // Sample data for sessions
    var body: some View {
        ZStack {
            Color.white
                .frame(minWidth: 608, idealWidth: 610)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .shadow(color: .black, radius: 2, x: 0, y: 2)
                .opacity(0.2)
            Color.white
                .frame(minWidth: 608, idealWidth: 610)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            
            VStack {
//                HStack(alignment: .top, spacing: 0) {
                HStack(spacing: 0) {
                    Text("Attendance Statistics for Day")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                        .frame(width: 250, alignment: .leading)
                    
                    DatePicker("", selection: $data.selectedDate, displayedComponents: .date)
                    Spacer()
                    
                    Picker("Session", selection: $session) {
                        ForEach(sessions, id: \.self) { session in
                            if session == "0" {
                                Text("Session A")
                            } else {
                                Text("Session B")
                            }
                        }
                    }
                    .accentColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                    .frame(width: 120,alignment: .trailing)
                }
                // Add your chart here
                ChartForDay(data: data, session: session)
            }
            .padding(28)
        }
//        .onTapGesture {
//            isDetailViewShown = true
//        }
//        .fullScreenCover(isPresented: $isDetailViewShown) {
//            ChartForDayView(data: data)
//        }
        
    }
}

struct ChartForDayView_Previews: PreviewProvider {
    static var previews: some View {
        ChartForDayView(data: HTTPClient())
    }
}
