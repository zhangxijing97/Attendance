//
//  TimeView.swift
//  Attendance
//
//  Created by 张熙景 on 3/18/23.
//

import SwiftUI

struct TimeView: View {
    @State var currentTime = Date() // Get the currentTime
    @State var isClockViewShown = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 0.9569, green: 0.9608, blue: 0.9686))
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            Text(currentTime, style: .time)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .frame(width: 50, height: 50)
                .lineLimit(2) // limit to 2 lines
                .multilineTextAlignment(.center) // center align the text
        }
        .frame(height: 70)
        .contentShape(Rectangle()) // Make tappable size bigger
        .onTapGesture {
            isClockViewShown = true // Show the date picker when the calendar icon is tapped
        }
        .onAppear {
            // Create a timer that updates the current date every second
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                currentTime = Date()
            }
        }
        .formSheet(isPresented: $isClockViewShown) {
            ClockView()
                .clearModalBackground()
        }
        .clipShape(RoundedRectangle(cornerRadius: 150, style: .continuous))
    }
}

struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        TimeView()
    }
}
