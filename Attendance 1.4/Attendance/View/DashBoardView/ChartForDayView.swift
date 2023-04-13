//
//  ChartForDayView.swift
//  Attendance
//
//  Created by 张熙景 on 3/18/23.
//

import SwiftUI

struct ChartForDayView: View {
    var body: some View {
        ZStack {
            Color.white
                .frame(width: 610)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .shadow(color: .black, radius: 2, x: 0, y: 2)
                .opacity(0.2)
            Color.white
                .frame(width: 610)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            ChartForDay()
        }
    }
}

struct ChartForDayView_Previews: PreviewProvider {
    static var previews: some View {
        ChartForDayView()
    }
}
