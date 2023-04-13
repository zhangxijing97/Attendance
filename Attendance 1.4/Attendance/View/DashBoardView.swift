//
//  DashBoardView.swift
//  Attendance
//
//  Created by 张熙景 on 3/17/23.
//

import SwiftUI

struct DashBoardView: View {
//    @ObservedObject var data: AppData
    @ObservedObject var data: HTTPClient
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
                .frame(width: 35)
            VStack(alignment: .leading, spacing: 0) {
                Text("DashBoard")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                    .frame(height: 35)
                ChartForDayView()
                Spacer()
                    .frame(height: 28)
                ChartForWeekView()
                Spacer()
                    .frame(height: 35)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                TrackListView(data: data)
            }
        }
    }
}

struct DashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardView(data: HTTPClient())
    }
}
