//
//  SectionView.swift
//  Attendance 1.32
//
//  Created by Xijing Zhang on 3/17/23.
//

import SwiftUI

struct TrackDetailView: View {
//    @ObservedObject var data: AppData
    @ObservedObject var data: HTTPClient
    @Binding var track: Track

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
        let attendances = data.getAttendanceForTrack(data: data, track: track)
        return attendances
    }


    var body: some View {
            List {
                Text(track.location)
                Text("Date: \(track.date)")
                ForEach(0..<track.sessions.count, id: \.self) { index in
                    VStack {
                        HStack {
                            Text("Section \(String(Character(UnicodeScalar(index + 65)!)).uppercased()) :")
                            Text(track.sessions[index])
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
                    ForEach(attendances) { attendance in
                        let student = data.getStudentForAttendance(attendance: attendance, students: data.students)!
                        HStack {
                            Text(student.name)
                                .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)

                            ForEach(attendance.day1Sessions, id: \.self) { session in
//                                let session = attendance.day1Sessions[sessionIndex]

                                if session.checkInTime != "1970-01-01T07:00:00Z" { // Check In Button For Section A
//                                    Text("\(session.checkInTime, formatter: dateFormatter)")
                                    Text(session.checkInTime)
                                        .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                } else {
                                    Button(action: {}) {
                                        Text("Check In")
                                            .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                    }
                                    .onTapGesture {
//                                        let attendanceIndex = data.attendances.firstIndex(where: { $0.id == self.attendances[index].id })
//                                        let currentDate = Date()
//                                        data.attendances[attendanceIndex!].day1Sessions[sessionIndex].checkInTime = currentDate
                                    }
                                }

                                if session.checkOutTime != "1970-01-01T07:00:00Z" { // Check Out Button For Section A
//                                    Text("\(session.checkOutTime, formatter: dateFormatter)")
                                    Text(session.checkOutTime)
                                        .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                } else {
                                    Button(action: {}) {
                                        Text("Check Out")
                                            .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                    }
                                    .onTapGesture {
//                                        let attendanceIndex = data.attendances.firstIndex(where: { $0.id == self.attendances[index].id })
//                                        let currentDate = Date()
//                                        data.attendances[attendanceIndex!].day1Sessions[sessionIndex].checkOutTime = currentDate
                                    }
                                }
                            }
                        }
                    }

                    case track.days[1]:
                    Text("2")
                    ForEach(attendances) { attendance in
                        let student = data.getStudentForAttendance(attendance: attendance, students: data.students)!
                        HStack {
                            Text(student.name)
                                .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)

                            ForEach(attendance.day2Sessions, id: \.self) { session in
//                                let session = attendance.day1Sessions[sessionIndex]

                                if session.checkInTime != "1970-01-01T07:00:00Z" { // Check In Button For Section A
//                                    Text("\(session.checkInTime, formatter: dateFormatter)")
                                    Text(session.checkInTime)
                                        .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                } else {
                                    Button(action: {}) {
                                        Text("Check In")
                                            .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                    }
                                    .onTapGesture {
//                                        let attendanceIndex = data.attendances.firstIndex(where: { $0.id == self.attendances[index].id })
//                                        let currentDate = Date()
//                                        data.attendances[attendanceIndex!].day2Sessions[sessionIndex].checkInTime = currentDate
                                    }
                                }
                                if session.checkOutTime != "1970-01-01T07:00:00Z" { // Check Out Button For Section A
//                                    Text("\(session.checkOutTime, formatter: dateFormatter)")
                                    Text(session.checkOutTime)
                                        .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                } else {
                                    Button(action: {}) {
                                        Text("Check Out")
                                            .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                    }
                                    .onTapGesture {
//                                        let attendanceIndex = data.attendances.firstIndex(where: { $0.id == self.attendances[index].id })
//                                        let currentDate = Date()
//                                        data.attendances[attendanceIndex!].day2Sessions[sessionIndex].checkOutTime = currentDate
                                    }
                                }
                            }
                        }
                    }

                    case track.days[2]:
                    Text("3")
                    ForEach(attendances) { attendance in
                        let student = data.getStudentForAttendance(attendance: attendance, students: data.students)!
                        HStack {
                            Text(student.name)
                                .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)

                            ForEach(attendance.day3Sessions, id: \.self) { session in
//                                let session = attendance.day1Sessions[sessionIndex]

                                if session.checkInTime != "1970-01-01T07:00:00Z" { // Check In Button For Section A
//                                    Text("\(session.checkInTime, formatter: dateFormatter)")
                                    Text(session.checkInTime)
                                        .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                } else {
                                    Button(action: {}) {
                                        Text("Check In")
                                            .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                    }
                                    .onTapGesture {
//                                        let attendanceIndex = data.attendances.firstIndex(where: { $0.id == self.attendances[index].id })
//                                        let currentDate = Date()
//                                        data.attendances[attendanceIndex!].day3Sessions[sessionIndex].checkInTime = currentDate
                                    }
                                }
                                if session.checkOutTime != "1970-01-01T07:00:00Z" { // Check Out Button For Section A
//                                    Text("\(session.checkOutTime, formatter: dateFormatter)")
                                    Text(session.checkOutTime)
                                        .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                } else {
                                    Button(action: {}) {
                                        Text("Check Out")
                                            .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                    }
                                    .onTapGesture {
//                                        let attendanceIndex = data.attendances.firstIndex(where: { $0.id == self.attendances[index].id })
//                                        let currentDate = Date()
//                                        data.attendances[attendanceIndex!].day3Sessions[sessionIndex].checkOutTime = currentDate
                                    }
                                }
                            }
                        }
                    }

                    case track.days[3]:
                    Text("4")
                    ForEach(attendances) { attendance in
                        let student = data.getStudentForAttendance(attendance: attendance, students: data.students)!
                        HStack {
                            Text(student.name)
                                .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)

                            ForEach(attendance.day4Sessions, id: \.self) { session in
//                                let session = attendance.day1Sessions[sessionIndex]

                                if session.checkInTime != "1970-01-01T07:00:00Z" { // Check In Button For Section A
//                                    Text("\(session.checkInTime, formatter: dateFormatter)")
                                    Text(session.checkInTime)
                                        .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                } else {
                                    Button(action: {}) {
                                        Text("Check In")
                                            .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                    }
                                    .onTapGesture {
//                                        let attendanceIndex = data.attendances.firstIndex(where: { $0.id == self.attendances[index].id })
//                                        let currentDate = Date()
//                                        data.attendances[attendanceIndex!].day4Sessions[sessionIndex].checkInTime = currentDate
                                    }
                                }
                                if session.checkOutTime != "1970-01-01T07:00:00Z" { // Check Out Button For Section A
//                                    Text("\(session.checkOutTime, formatter: dateFormatter)")
                                    Text(session.checkOutTime)
                                        .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                } else {
                                    Button(action: {}) {
                                        Text("Check Out")
                                            .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                    }
                                    .onTapGesture {
//                                        let attendanceIndex = data.attendances.firstIndex(where: { $0.id == self.attendances[index].id })
//                                        let currentDate = Date()
//                                        data.attendances[attendanceIndex!].day4Sessions[sessionIndex].checkOutTime = currentDate
                                    }
                                }
                            }
                        }
                    }

                    case track.days[4]:
                    Text("5")
                    ForEach(attendances) { attendance in
                        let student = data.getStudentForAttendance(attendance: attendance, students: data.students)!
                        HStack {
                            Text(student.name)
                                .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)

                            ForEach(attendance.day5Sessions, id: \.self) { session in
//                                let session = attendance.day1Sessions[sessionIndex]

                                if session.checkInTime != "1970-01-01T07:00:00Z" { // Check In Button For Section A
//                                    Text("\(session.checkInTime, formatter: dateFormatter)")
                                    Text(session.checkInTime)
                                        .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                } else {
                                    Button(action: {}) {
                                        Text("Check In")
                                            .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                    }
                                    .onTapGesture {
//                                        let attendanceIndex = data.attendances.firstIndex(where: { $0.id == self.attendances[index].id })
//                                        let currentDate = Date()
//                                        data.attendances[attendanceIndex!].day5Sessions[sessionIndex].checkInTime = currentDate
                                    }
                                }
                                if session.checkOutTime != "1970-01-01T07:00:00Z" { // Check Out Button For Section A
//                                    Text("\(session.checkOutTime, formatter: dateFormatter)")
                                    Text(session.checkOutTime)
                                        .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                } else {
                                    Button(action: {}) {
                                        Text("Check Out")
                                            .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                                    }
                                    .onTapGesture {
//                                        let attendanceIndex = data.attendances.firstIndex(where: { $0.id == self.attendances[index].id })
//                                        let currentDate = Date()
//                                        data.attendances[attendanceIndex!].day5Sessions[sessionIndex].checkOutTime = currentDate
                                    }
                                }
                            }
                        }
                    }
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
        return TrackDetailView(data: HTTPClient(), track: .constant(track))
    }
}
