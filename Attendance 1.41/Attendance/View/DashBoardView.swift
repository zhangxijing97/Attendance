//
//  DashBoardView.swift
//  Attendance
//
//  Created by 张熙景 on 3/17/23.
//

import SwiftUI

struct DashBoardView: View {
    @ObservedObject var data: HTTPClient
    
    var body: some View {
        HStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("DashBoard")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                        .frame(height: 35)
                        .padding(.leading, 35)
                    ChartForDayView(data: data)
//                        .frame(height: 400)
                        .frame(minHeight: 300, idealHeight: 326)
                        .padding(.bottom, 28)
                        .padding(.leading, 35)
                        .padding(.trailing, 20)
                    ChartForWeekView(data: data)
//                        .frame(height: 400)
                        .frame(minHeight: 300, idealHeight: 326)
                        .padding(.bottom, 35)
                        .padding(.leading, 35)
                        .padding(.trailing, 20)
                }
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
