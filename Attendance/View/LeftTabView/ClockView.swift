//
//  SkeuomorphicClockView.swift
//  Attendance
//
//  Created by 张熙景 on 3/21/23.
//

import SwiftUI

struct ClockView: View {
    @State private var currentTime = Date()
    
    @State private var hours = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    
    private var timeComponents: DateComponents {
        Calendar.current.dateComponents([.hour, .minute, .second], from: currentTime)
    }
    
    private var hourAngle: Double {
        Double(timeComponents.hour ?? 0) / 12.0 * 2 * .pi
    }
    
    private var minuteAngle: Double {
        Double(timeComponents.minute ?? 0) / 60.0 * 2 * .pi
    }
    
    private var secondAngle: Double {
        Double(timeComponents.second ?? 0) / 60.0 * 2 * .pi
    }
    
    let clockFrameSize: CGFloat = 436
    let clockBackgroundColor = Color.black
    let clockDialColor = Color(red: 0.9608, green: 0.9608, blue: 0.9725)
    let clockHourColor = Color.black
    let clockMinuteColor = Color.black
    let clockSecondColor = Color.orange
    
    let clockHourWidth: CGFloat = 10
    let clockMinuteWidth: CGFloat = 10
    let clockSecondWidth: CGFloat = 6
    let clockHandWidth: CGFloat = 6
    
    var body: some View {
        let clockCenter = CGPoint(x: clockFrameSize / 2, y: clockFrameSize / 2)
        let minuteHandLength = clockFrameSize / 2.5
        let hourHandLength = minuteHandLength / 2
        
        return ZStack {
            
            Rectangle()
                .fill(clockBackgroundColor)
                .cornerRadius(110)
            
            Circle()
                .fill(clockDialColor)
                .frame(width: clockFrameSize, height: clockFrameSize)
            
            // Show hours number
            ForEach(hours, id: \.self) { hour in
                Text("\(hour)" as String)
                    .rotationEffect(Angle(degrees: -Double(hour) * 30))
                    .font(.system(size: 60, weight: .medium))
                    .offset(y: -clockFrameSize/2 + 45)
                    .rotationEffect(Angle(degrees: Double(hour) * 30))
            }
            
            // Hour
            Rectangle()
                .fill(clockHourColor)
                .frame(width: 10, height: hourHandLength)
                .cornerRadius(5)
                .offset(y: -hourHandLength / 2)
                .rotationEffect(Angle(radians: hourAngle))
            
            // Minute
            Rectangle()
                .fill(clockMinuteColor)
                .frame(width: 10, height: minuteHandLength)
                .cornerRadius(5)
                .offset(y: -minuteHandLength / 2)
                .rotationEffect(Angle(radians: minuteAngle))
            
            Circle()
                .fill(clockHourColor)
                .frame(width: clockHandWidth * 5, height: clockHandWidth * 5)
            
            // Second
            Rectangle()
                .fill(clockSecondColor)
                .frame(width: clockSecondWidth, height: minuteHandLength + 40)
                .offset(y: -(minuteHandLength + 10) / 2 + 30)
                .rotationEffect(Angle(radians: secondAngle))
            
            Circle()
                .fill(clockSecondColor)
                .frame(width: clockHandWidth * 3, height: clockHandWidth * 3)
            
            Circle()
                .fill(clockDialColor)
                .frame(width: clockHandWidth * 1, height: clockHandWidth * 1)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                currentTime = Date()
            }
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}
