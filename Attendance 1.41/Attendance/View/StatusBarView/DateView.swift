//
//  DateView.swift
//  Attendance
//
//  Created by 张熙景 on 3/18/23.
//

import SwiftUI

struct DateView: View {
    @ObservedObject var data: HTTPClient
    var startOfWeek = Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 12))!
    var endOfWeek = Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 30))!
    @State var isDatePickerShown = false // Track whether the date picker should be shown or hidden
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 35)
            VStack(alignment: .leading) {
                Text("Attendance")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                HStack {
                    Text(data.selectedDate, style: .date)
                        .font(.system(.body, design: .rounded))
                        .bold()
                    Image(systemName: "calendar")
                        .font(.system(.body, design: .rounded))
                        .bold()
                }
                .foregroundColor(isDatePickerShown ? Color(red: 0.3294, green: 0.3647, blue: 0.9215) : Color(red: 0.0000, green: 0.1176, blue: 0.2824))
            }
        }
        .frame(height: 70)
        .contentShape(Rectangle()) // Make tappable size bigger
        .onTapGesture {
            isDatePickerShown = true // Show the date picker when the calendar icon is tapped
        }
        .onAppear {
            // Create a timer that updates the current date every 300 second
            Timer.scheduledTimer(withTimeInterval: 300, repeats: true) { timer in
                data.selectedDate = Date()
            }
        }
        .formSheet(isPresented: $isDatePickerShown) {
            DatePicker("Select Date", selection: $data.selectedDate, in: startOfWeek...endOfWeek, displayedComponents: .date)
                .datePickerStyle(.graphical)
        }
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView(data: HTTPClient())
    }
}
