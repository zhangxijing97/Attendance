//
//  ChartForDay.swift
//  Attendance
//
//  Created by 张熙景 on 3/19/23.
//

import SwiftUI
import Charts

struct ChartForDay: View {
    @ObservedObject var data: HTTPClient
    var session: String
    
    // Get selectedDate
    var selectedDate: Date {
        return data.selectedDate
    }
    
    // Get tracks
    private func tracks() -> [Track]? {
        let tracks = data.tracks
        return tracks
    }
    
    // Get all tracks match the date
    private func tracksForDate() -> [Track]? {
        guard let tracks = tracks() else { return nil }
        let formatter = DateFormatter()
        let tracksForDate = tracks.filter { track in
            let hoursInSeconds: TimeInterval = 60 * 60
            let startDateWithOffset = track.startDate.addingTimeInterval(hoursInSeconds * 7)
            let endDateWithOffset = track.endDate.addingTimeInterval(hoursInSeconds * 7)
            return startDateWithOffset.formatted(date: .long, time: .omitted) <= selectedDate.formatted(date: .long, time: .omitted) && endDateWithOffset.formatted(date: .long, time: .omitted) >= selectedDate.formatted(date: .long, time: .omitted)
        }
        return tracksForDate.isEmpty ? nil : tracksForDate
    }
    
    // Sorted tracks
    private func sortedTracksForDate() -> [Track]? {
        guard let tracks = tracksForDate() else { return nil }
        return tracks.sorted { $0.name < $1.name }
    }
    
    // Function below is for students
    // Get all trackstudents for the track
    private func trackstudentsForTrack(track: Track) -> [TrackStudent]? {
        let trackstudents = data.trackstudents.filter { $0.track_id == track.id }
        return trackstudents.isEmpty ? nil : trackstudents
    }
    
    // Get all students for the track
    private func studentsForTrack(track: Track) -> [Student]? {
        guard let trackstudents = trackstudentsForTrack(track: track) else { return [] }
        let students = data.students.filter { student in
            trackstudents.contains(where: { $0.student_id == student.id })
        }
        return students.isEmpty ? nil : students
    }
    
    // Get number of Students
    private func numberOfStudents(track: Track) -> Int {
        return studentsForTrack(track: track)?.count ?? 0
    }
    
    // Function below is for attendances
    // Get all attendances match the trackstudents
    private func attendancesForTrack(track: Track) -> [Attendance]? {
        guard let trackstudents = trackstudentsForTrack(track: track) else { return [] }
        let attendances = data.attendances.filter { attendance in
            trackstudents.contains(where: { $0.id == attendance.trackstudent_id })
        }
        return attendances.isEmpty ? nil : attendances
    }
    
    // Get all attendances match the date
    private func attendancesForDate(track: Track) -> [Attendance]? {
        guard let attendancesForTrack = attendancesForTrack(track: track) else { return nil }
        let formatter = DateFormatter()
        let attendances = attendancesForTrack.filter { attendance in
            let hoursInSeconds: TimeInterval = 60 * 60
            let dateWithOffset = attendance.date.addingTimeInterval(hoursInSeconds * 7)
            return dateWithOffset.formatted(date: .long, time: .omitted) == selectedDate.formatted(date: .long, time: .omitted)
        }
        return attendances.isEmpty ? nil : attendances
    }
    
    // Get all attendances match the session
    private func attendancesForSession(track: Track) -> [Attendance]? {
        guard let attendancesForDate = attendancesForDate(track: track) else { return nil }
        let attendances = attendancesForDate.filter { $0.sessionNumber == String(session) }
        return attendances.isEmpty ? nil : attendances
    }
    
    // Get number of Attendances
    private func numberOfAttendances(track: Track) -> Int {
        return attendancesForSession(track: track)?.count ?? 0
    }
    
    // Get number of checkIn
    private func numberOfCheckedInAttendances(track: Track) -> Int {
        guard let attendances = attendancesForSession(track: track) else { return 0 }
        return attendances.filter { $0.checkInTime != Date(timeIntervalSince1970: 0) }.count
    }
    
    // Get number of checkOut
    private func numberOfCheckedOutAttendances(track: Track) -> Int {
        guard let attendances = attendancesForSession(track: track) else { return 0 }
        return attendances.filter { $0.checkOutTime != Date(timeIntervalSince1970: 0) }.count
    }

    var body: some View {
        VStack {
            let tracks = sortedTracksForDate()
            
            if tracks == nil {
                // Get all Tracks
                
                if data.tracks == nil {
                    ProgressView()
                } else {
                    Chart(data.tracks) { track in
                        let numberOfStudents = numberOfStudents(track: track)
                        let numberOfCheckedIn = numberOfCheckedInAttendances(track: track)
                        let numberOfCheckedOut = numberOfCheckedInAttendances(track: track)
                        BarMark(
                            x: .value("Tracks", track.name),
                            y: .value("Number of Students", numberOfStudents)
                        )
                        .foregroundStyle(Color(red: 0.3294, green: 0.3647, blue: 0.9215))
                        .position(by: .value("track", 0))
                    }
                    .chartYAxis {
                        AxisMarks(position: .leading)
                    }
                    .chartForegroundStyleScale([
                        "Number of Students" : Color(red: 0.3294, green: 0.3647, blue: 0.9215),
                        "Number of Check In" : Color(red: 0.0000, green: 0.7804, blue: 0.9215),
                        "Number of Check Out" : Color(red: 0.1960, green: 0.8040, blue: 0.1960)
                    ])
                }
                
            } else {
                // Get Tracks match the date
                Chart(tracks!) { track in
                    let numberOfStudents = numberOfStudents(track: track)
                    let numberOfCheckedIn = numberOfCheckedInAttendances(track: track)
                    let numberOfCheckedOut = numberOfCheckedOutAttendances(track: track)
                    
                    BarMark(
                        x: .value("Tracks", track.name),
                        y: .value("Number of Students", numberOfStudents)
                    )
                    .foregroundStyle(Color(red: 0.3294, green: 0.3647, blue: 0.9215))
                    .position(by: .value("track", 0))
                    .offset(x: 40)
                    
                    BarMark(
                        x: .value("Tracks", track.name),
                        y: .value("Number of Check In", numberOfCheckedIn)
                    )
                    .foregroundStyle(Color(red: 0.0000, green: 0.7804, blue: 0.9215))
                    .position(by: .value("track", 1))
                    
                    BarMark(
                        x: .value("Tracks", track.name),
                        y: .value("Number of Check Out", numberOfCheckedOut)
                    )
                    .foregroundStyle(Color(red: 0.1960, green: 0.8040, blue: 0.1960))
                    .position(by: .value("track", 2))
                    .offset(x: -40)
                }
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .chartForegroundStyleScale([
                    "Number of Students" : Color(red: 0.3294, green: 0.3647, blue: 0.9215),
                    "Number of Check In" : Color(red: 0.0000, green: 0.7804, blue: 0.9215),
                    "Number of Check Out" : Color(red: 0.1960, green: 0.8040, blue: 0.1960)
                ])
                
            }
            
        }
    }
}

struct ChartForDay_Previews: PreviewProvider {
    static var previews: some View {
        ChartForDay(data: HTTPClient(), session: "")
    }
}
