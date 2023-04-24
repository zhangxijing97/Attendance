//
//  ChartForWeek.swift
//  Attendance
//
//  Created by 张熙景 on 3/18/23.
//

import SwiftUI

struct ChartForWeekView: View {
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
//            ChartForDay()
        }
        .padding(.bottom, 35)
        .padding(.leading, 35)
        .padding(.trailing, 20) // Add 15 leading padding for TrackView
    }
}

struct ChartForWeekView_Previews: PreviewProvider {
    static var previews: some View {
        ChartForWeekView()
    }
}
