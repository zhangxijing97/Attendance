//
//  TrackView.swift
//  Attendance 1.32
//
//  Created by Xijing Zhang on 3/17/23.
//

import SwiftUI

struct TrackView: View {
    @ObservedObject var data: HTTPClient
    var track: Track
    
    // Get selectedDate
    var selectedDate: Date {
        return data.selectedDate
    }
    
    // Function below is for students
    // Get all trackstudents for the track
    private func trackstudentsForTrack() -> [TrackStudent]? {
        let trackstudents = data.trackstudents.filter { $0.track_id == track.id }
        return trackstudents.isEmpty ? nil : trackstudents
    }
    
    // Get all students for the track
    private func studentsForTrack() -> [Student]? {
        guard let trackstudents = trackstudentsForTrack() else { return [] }
        let students = data.students.filter { student in
            trackstudents.contains(where: { $0.student_id == student.id })
        }
        return students.isEmpty ? nil : students
    }
    
    // Get number of Students
    private func numberOfStudents() -> Int {
        return studentsForTrack()?.count ?? 0
    }
    
    // All function below is for attendances
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

    // Get number of Attendances
    private func totalAttendances() -> Int {
        return attendancesForDate()?.count ?? 0
    }
    
    // Get number of checkIn
    private func numberOfCheckedInAttendances() -> Int {
        guard let attendances = attendancesForDate() else { return 0 }
        return attendances.filter { $0.checkInTime != Date(timeIntervalSince1970: 0) }.count
    }
    
    // Get number of checkOut
    private func numberOfCheckedOutAttendances() -> Int {
        guard let attendances = attendancesForDate() else { return 0 }
        return attendances.filter { $0.checkOutTime != Date(timeIntervalSince1970: 0) }.count
    }
    
    var body: some View {
        
        ZStack {
            Color.white
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .shadow(color: .black, radius: 2, x: 0, y: 2)
                .opacity(0.2)
            // Background of TrackView
            Color.white
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                    .frame(height: 16)
                
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        Text("Total")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                        Spacer()
                            .frame(height: 38)
                        Text("\(numberOfStudents())")
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                        Spacer()
                    }
                    .frame(width: 108)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(track.sessions.indices, id: \.self) { index in
                            SessionView(data: data, track: track, sessionIndex: index)
                            Spacer()
                                .frame(height: 20)
                        }
                    }
                    Spacer()
                        .frame(width: 18)
                }
                .frame(height: 155)
                
                Rectangle()
                    .fill(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                    .opacity(0.2)
                    .frame(height: 1)
                HStack {
                    Image(systemName: "square.stack.3d.up.badge.a.fill")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                    Text(track.name)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                }
                .padding(.leading, 18)
                .frame(height: 40)
                
            }
        }
        
    }
}

struct TrackView_Previews: PreviewProvider {
    static var previews: some View {
        let track = Track.example
        TrackView(data: HTTPClient(), track: track)
    }
}
