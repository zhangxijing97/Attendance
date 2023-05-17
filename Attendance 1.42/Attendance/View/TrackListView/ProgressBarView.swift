//
//  ProgressBarView.swift
//  Attendance
//
//  Created by 张熙景 on 4/5/23.
//

import SwiftUI

struct ProgressBarView: View {
    var numberOfAttended: Int
    var totalAttendances: Int
    
    var widthOfAttended: Int {
        if totalAttendances == 0 {
            return 0
        }
        return Int((CGFloat(120) * CGFloat(numberOfAttended)) / CGFloat(totalAttendances))
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 0.8471, green: 0.8471, blue: 0.8471))
                .frame(width: 120, height: 6)
                .cornerRadius(3)
            Rectangle()
                .fill(Color(red: 0.3294, green: 0.3647, blue: 0.9215))
                .frame(width: CGFloat(widthOfAttended), height: 6)
                .cornerRadius(3)
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(numberOfAttended: 0, totalAttendances: 0)
    }
}
