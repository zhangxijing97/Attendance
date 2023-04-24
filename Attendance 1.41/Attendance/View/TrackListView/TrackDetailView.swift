//
//  SectionView.swift
//  Attendance 1.32
//
//  Created by Xijing Zhang on 3/17/23.
//

import SwiftUI

struct TrackDetailView: View {
    @ObservedObject var data: HTTPClient
    var track: Track
    @State private var showingAddStudentToTrackView = false
    @State var selectedDate = Date()
    
    var startOfWeek = Calendar.current.date(from: DateComponents(year: 2023, month: 2, day: 13))!
    var endOfWeek = Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 30))!
    
    @State private var session = 0
    
    // Get all trackstudents for the track
    private func trackstudentsForTrack() -> [TrackStudent]? {
        let trackstudents = data.trackstudents.filter { $0.track_id == track.id }
        return trackstudents.isEmpty ? nil : trackstudents
    }
    
    // Get all attendances match the trackstudents
    private func attendancesForTrack() -> [Attendance]? {
        guard let trackstudents = trackstudentsForTrack() else { return [] }
        let attendances = data.attendances.filter { attendance in
            trackstudents.contains(where: { $0.id == attendance.trackstudent_id })
        }
        return attendances.isEmpty ? nil : attendances
    }
    
    // Get all attendances match the date
    private func attendancesForDate() -> [Attendance]? {
        guard let attendancesForTrack = attendancesForTrack() else { return nil }
        let formatter = DateFormatter()
        let attendances = attendancesForTrack.filter { attendance in
            let hoursInSeconds: TimeInterval = 60 * 60
            let dateWithOffset = attendance.date.addingTimeInterval(hoursInSeconds * 7)
            return dateWithOffset.formatted(date: .long, time: .omitted) == selectedDate.formatted(date: .long, time: .omitted)
        }
        return attendances.isEmpty ? nil : attendances
    }
    
    // Get all attendances match the session
    private func attendancesForSession() -> [Attendance]? {
        guard let attendancesForDate = attendancesForDate() else { return nil }
        let attendances = attendancesForDate.filter { $0.sessionNumber == String(session) }
        return attendances.isEmpty ? nil : attendances
    }
    
    // Function to get student for attendance
    private func studentForAttendance(attendance: Attendance) -> Student? {
        guard let trackStudent = data.trackstudents.first(where: { $0.id == attendance.trackstudent_id }) else {
            return nil
        }
        return data.students.first(where: { $0.id == trackStudent.student_id })
    }
    
    // Get session
    private func getSession() -> Session? {
        let calendar = Calendar.current
        
        return data.sessions.first(where: { sessionObj in
            let hoursInSeconds: TimeInterval = 60 * 60
            let dateWithOffset = sessionObj.date.addingTimeInterval(hoursInSeconds * 7)
            
            let sessionDateComponents = calendar.dateComponents([.year, .month, .day], from: dateWithOffset)
            let selectedDateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
            
            return sessionObj.track_id == track.id &&
                   sessionObj.sessionNumber == String(session) &&
                   sessionDateComponents == selectedDateComponents
        })
    }
    
    private func startDate() -> Date {
        let hoursInSeconds: TimeInterval = 60 * 60
        let startDate = track.startDate.addingTimeInterval(hoursInSeconds * 7)
        return startDate
    }
    
    private func endDate() -> Date {
        let hoursInSeconds: TimeInterval = 60 * 60
        let endDate = track.endDate.addingTimeInterval(hoursInSeconds * 7)
        return endDate
    }
    
    private func totalAttendances() -> Int {
        return attendancesForSession()?.count ?? 0
    }
    
    // Get number of checkIn
    private func numberOfCheckedInAttendances() -> Int {
        guard let attendances = attendancesForSession() else { return 0 }
        return attendances.filter { $0.checkInTime != Date(timeIntervalSince1970: 0) }.count
    }
    
    // Get number of checkOut
    private func numberOfCheckedOutAttendances() -> Int {
        guard let attendances = attendancesForSession() else { return 0 }
        return attendances.filter { $0.checkOutTime != Date(timeIntervalSince1970: 0) }.count
    }
    
    
   // Sorted Attendances
    private func sortedAttendancesForSession() -> [Attendance]? {
        guard let attendances = attendancesForSession() else { return nil }
        return attendances.sorted {
            guard let student1 = studentForAttendance(attendance: $0),
                  let student2 = studentForAttendance(attendance: $1) else {
                return false
            }
            return student1.name < student2.name
        }
    }

    var body: some View {
        
        List {
            Section {
                Text("Track: \(track.name)")
                Text("Level: \(track.level)")
                Text("Location: \(track.location)")
//                Text(track.name)
//                Text(track.level)
//                Text(track.location)
                ForEach(track.sessions.indices) { index in
                    let session = track.sessions[index]
                    VStack {
                        HStack {
                            Text("Session \(String(Character(UnicodeScalar(index + 65)!)).uppercased()) :")
                            Text(session)
                        }
                    }
                }
                Text("Start Date: \(startDate().formatted(date: .long, time: .omitted))")
                Text("End Date: \(endDate().formatted(date: .long, time: .omitted))")
            }
            
            Section {
                HStack {
                    
                    Image(systemName: "calendar")
                    DatePicker("Select Date", selection: $selectedDate, in: startOfWeek...endOfWeek, displayedComponents: .date)
                }
                
                Picker("Session", selection: $session) {
                    ForEach(track.sessions.indices) { index in
                        Text("Session \(String(Character(UnicodeScalar(index + 65)!)).uppercased()) ")
                    }
                }
                
                let session = getSession()
                if session == nil {
                    EmptyView()
                } else {
                    Text("Start Time: \(session!.startTime.formatted(date: .omitted, time: .standard))")
                    Text("End Time: \(session!.endTime.formatted(date: .omitted, time: .standard))")
                    
                    Text("Check In: \(numberOfCheckedInAttendances()) / \(totalAttendances())")
                    Text("Check Out: \(numberOfCheckedOutAttendances()) / \(totalAttendances())")
                }
                
            }
            
            Section {

                HStack {
                    Text("All Students").bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Check in").bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Check out").bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Button {
                        showingAddStudentToTrackView.toggle()
                        
                    } label: {
                        HStack {
                            Image(systemName: "slider.horizontal.3")
                            Text("Edit")
                        }
                    }
                    .frame(alignment: .trailing)
                }
                
                let attendances = sortedAttendancesForSession()
//                let attendances = attendancesForSession()
//                let students = studentsForTrackstudents()

                if attendances == nil {
                    EmptyView()
                } else {
                    ForEach(attendances!) { attendance in
                        HStack {
                            if let student = studentForAttendance(attendance: attendance) {
                                Text(student.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            } else {
                                Text("Unknown")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            CheckInView(data: data, attendance: attendance, onUpdate: {self.data.readData()})
                                .frame(maxWidth: .infinity, alignment: .leading)
                            CheckOutView(data: data, attendance: attendance, onUpdate: {self.data.readData()})
                                .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                Image(systemName: "slider.horizontal.3")
                                Text("Edit")
                            }
                            .frame(alignment: .trailing)
                            .foregroundColor(Color.white)
                        }
                    }
                    .onAppear {
                        self.data.readData()
                    }
                }
                
            }
        }
        .sheet(isPresented: $showingAddStudentToTrackView, onDismiss: {
            self.data.readData()
        }, content: {
            AddStudentToTrackView(data: data, track: track, dismiss: $showingAddStudentToTrackView)
        })
    }
}

struct TrackDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let track = Track.example
        TrackDetailView(data: HTTPClient(), track: track)
    }
}
