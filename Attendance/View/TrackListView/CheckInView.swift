//
//  CheckInView.swift
//  AttendancesAppTest
//
//  Created by 张熙景 on 4/12/23.
//

import SwiftUI

enum Status {
    case defaultStatus // Before check in
    case ontime // Attend and on time
    case late // Attend but late
    case absent // Absent
}

struct CheckInView: View {
    @ObservedObject var data: HTTPClient
    var attendance: Attendance
    @State private var isLoading = false
    @State private var showRealTime = false
    var onUpdate: () -> Void
    @State private var showAlert = false
    
    // Get trackstudent match the attendances
    private func trackstudentForAttendance() -> TrackStudent? {
        return data.trackstudents.first(where: { $0.id == attendance.trackstudent_id })
    }
    // Get track for the trackstudent
    private func trackForTrackStudent() -> Track? {
        guard let trackStudent = trackstudentForAttendance() else { return nil }
        return data.tracks.first(where: { $0.id == trackStudent.track_id })
    }
    
    // Get session for the track and attendance
    private func sessionForTrackAndAttendance() -> Session? {
        guard let track = trackForTrackStudent() else { return nil }
        return data.sessions.first(where: { session in
            session.track_id == track.id &&
            session.date == attendance.date &&
            session.sessionNumber == attendance.sessionNumber
        })
    }
    
    private func statusForAttendance() -> Status {
        guard let session = sessionForTrackAndAttendance() else { return .defaultStatus }
        let timeInterval = attendance.checkInTime.timeIntervalSince(session.startTime)
        
        let currentTime = Date()
        let timeIntervalForCurrentTime = currentTime.timeIntervalSince(session.startTime)
        
        let hoursInSeconds: TimeInterval = 60 * 60
        if attendance.checkInTime == Date(timeIntervalSince1970: 0) && timeIntervalForCurrentTime > hoursInSeconds * 3 {
            return .absent
        } else if attendance.checkInTime == Date(timeIntervalSince1970: 0) {
            return .defaultStatus
        } else if timeInterval <= 0 {
            return .ontime
        } else if timeInterval > 0 {
            return .late
        } else {
            return .defaultStatus
        }
    }

    private func updateAttendance(attendance: Attendance) {
        self.isLoading = true
        HTTPClient().updateAttendance(attendance) { success in
            if success {
                print("Attendance updated successfully.")
                onUpdate()
            } else {
                print("Attendance update failed.")
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
    
    var body: some View {
        let status = statusForAttendance()
        
        if status == .absent {
            
            if isLoading {
                ProgressView()
            } else {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.orange)
                    Text("Absent")
                }
                .onTapGesture {
                    showAlert = true
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Late Attendance"),
                          message: Text("You are marked as absent. Do you want to update your attendance as late?"),
                          primaryButton: .default(Text("Update as Late")) {
                        let hoursInSeconds: TimeInterval = 60 * 60
                        let date = attendance.date.addingTimeInterval(hoursInSeconds * 7)
                        
                        let attendance = Attendance(id: attendance.id, trackstudent_id: attendance.trackstudent_id, date: date, sessionNumber: attendance.sessionNumber, checkInTime: Date(), checkOutTime: attendance.checkOutTime)
                        self.updateAttendance(attendance: attendance)
                    },
                          secondaryButton: .cancel(Text("Cancel")))
                }
            }
            
            
        } else if status == .ontime {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                if showRealTime {
                    Text(attendance.checkInTime.formatted(date: .omitted, time: .standard))
                } else {
                    Text("Attend")
                }
            }
            .onTapGesture {
                showRealTime.toggle()
            }
        } else if status == .late {
            HStack {
                Image(systemName: "clock.badge.checkmark.fill")
                    .foregroundColor(.blue)
                if showRealTime {
                    Text(attendance.checkInTime.formatted(date: .omitted, time: .standard))
                } else {
                    Text("Late")
                }
            }
            .onTapGesture {
                showRealTime.toggle()
            }
        } else {
            
            if isLoading {
                ProgressView()
            } else {
                Button(action: {}) {
                    Text("Check In")
                }
                .onTapGesture {
                    let hoursInSeconds: TimeInterval = 60 * 60
                    let date = attendance.date.addingTimeInterval(hoursInSeconds * 7)
                    
                    let attendance = Attendance(id: attendance.id, trackstudent_id: attendance.trackstudent_id, date: date, sessionNumber: attendance.sessionNumber, checkInTime: Date(), checkOutTime: attendance.checkOutTime)
                    self.updateAttendance(attendance: attendance)
                }
            }
            
        }
    }
}

struct CheckInView_Previews: PreviewProvider {
    static var previews: some View {
        CheckInView(data: HTTPClient(), attendance: Attendance(id: UUID(), trackstudent_id: UUID(), date: Date(), sessionNumber: "0", checkInTime: Date(), checkOutTime: Date()), onUpdate: {})
    }
}
