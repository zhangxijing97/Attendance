//
//  SectionView.swift
//  Attendance1.0
//
//  Created by 张熙景 on 2/2/23.
//

import SwiftUI

struct TrackDetailView: View {
    @Binding var track: Track
    @ObservedObject var data: AppData
    
    @State private var showingShowStudentView = false // Show
    @State var selectedDate = Date()
    var startOfWeek = Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 12))!
    var endOfWeek = Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 30))!
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd HH:mm"
        return dateFormatter
    }
    
    var selectedDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        return dateFormatter.string(from: selectedDate)
    }
    
    var attendances: [Attendance] {
        track.getAttendances(data: data)
    }
    
    var body: some View {
            List {
                Text(track.location)
                Text("Date: \(track.date)")
                ForEach(0..<track.sections.count, id: \.self) { index in
                    VStack {
                        HStack {
                            Text("Section \(String(Character(UnicodeScalar(index + 65)!)).uppercased()) :")
                            Text(track.sections[index])
                        }
                    }
                }
                
                HStack {
                    Image(systemName: "calendar")
                    DatePicker("Select Date", selection: $selectedDate, in: startOfWeek...endOfWeek, displayedComponents: .date)
                }
                
                HStack {
                    Text("All Students").bold()
                        .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                    Text("Section A").bold()
                        .frame(minWidth: 190, idealWidth: 380, maxWidth: 400, alignment: .leading)
                    Text("Section B").bold()
                        .frame(minWidth: 190, idealWidth: 380, maxWidth: 400, alignment: .leading)
                    Button {
                        showingShowStudentView.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "slider.horizontal.3")
                            Text("Edit")
                        }
                    }
                    .frame(alignment: .trailing)
                }
                
                switch selectedDateString {
                    case track.days[0]:
                    Text("1")
                    ForEach(attendances.indices, id: \.self) { index in
                        HStack {
                            Text("\(attendances[index].studentName(attendance: attendances[index])!)" as String)
                                .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                            
                            ForEach(attendances[index].day1Sessions.indices) { sessionIndex in
                                let session = attendances[index].day1Sessions[sessionIndex]
                                
                                if session.checkInTime != Date(timeIntervalSince1970: 0) { // Check In Button For Section A
                                    Text("\(session.checkInTime, formatter: dateFormatter)")
                                        .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                } else {
                                    Button(action: {}) {
                                        Text("Check In")
                                            .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                    }
                                    .onTapGesture {
                                        let attendanceIndex = data.attendances.firstIndex(where: { $0.id == self.attendances[index].id })
                                        let currentDate = Date()
                                        data.attendances[attendanceIndex!].day1Sessions[sessionIndex].checkInTime = currentDate
                                    }
                                }
                                if session.checkOutTime != Date(timeIntervalSince1970: 0) { // Check Out Button For Section A
                                    Text("\(session.checkOutTime, formatter: dateFormatter)")
                                        .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                } else {
                                    Button(action: {}) {
                                        Text("Check Out")
                                            .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                    }
                                    .onTapGesture {
                                        let attendanceIndex = data.attendances.firstIndex(where: { $0.id == self.attendances[index].id })
                                        let currentDate = Date()
                                        data.attendances[attendanceIndex!].day1Sessions[sessionIndex].checkOutTime = currentDate
                                    }
                                }
                            }
                        }
                    }
                    
                    case track.days[1]:
                    Text("2")
                    case track.days[2]:
                    Text("3")
                    case track.days[3]:
                    Text("4")
                    case track.days[4]:
                    Text("5")
                    default:
                    Text("Note: The Track doesn't have courses today")
                }
            }
        .sheet(isPresented: $showingShowStudentView) {
            ShowStudentView(track: $track, data: data, dismiss: $showingShowStudentView)
        }
    }
}

struct TrackDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let track = Track.example
        return TrackDetailView(track: .constant(track), data: AppData())
    }
}
