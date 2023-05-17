//
//  SessionView.swift
//  Attendance
//
//  Created by 张熙景 on 3/19/23.
//

import SwiftUI

struct SessionView: View {
    @ObservedObject var data: HTTPClient
    var track: Track
    var sessionIndex: Int
    
    // Get selectedDate
    var selectedDate: Date {
        return data.selectedDate
    }
    
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
        let attendances = attendancesForDate.filter { $0.sessionNumber == String(sessionIndex) }
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
                   sessionObj.sessionNumber == String(sessionIndex) &&
                   sessionDateComponents == selectedDateComponents
        })
    }
    
    // Get number of Attendances
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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text("< ")
                Text(track.sessions[sessionIndex])
                Text(" >")
            }
            Spacer()
                .frame(height: 10)
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("Check In:")
                        Spacer()
                        Text("\(numberOfCheckedInAttendances()) / \(totalAttendances())")
                    }
                    Spacer()
                        .frame(height: 10)
                    ProgressBarView(numberOfAttended: numberOfCheckedInAttendances(), totalAttendances: totalAttendances())
                }
                .frame(width: 120)
                Spacer()
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("Check Out:")
                        Spacer()
                        Text("\(numberOfCheckedOutAttendances()) / \(totalAttendances())")
                    }
                    Spacer()
                        .frame(height: 10)
                    ProgressBarView(numberOfAttended: numberOfCheckedOutAttendances(), totalAttendances: totalAttendances())
                }
                .frame(width: 120)
            }
        }
        .font(.system(size: 14, weight: .medium, design: .rounded))
        .foregroundColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        let track = Track.example
        let session = "Introduction to Audio Production"
        SessionView(data: HTTPClient(), track: track, sessionIndex: 0)
    }
}
