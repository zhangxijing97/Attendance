//
//  ShowStudentView.swift
//  Attendance 1.32
//
//  Created by Xijing Zhang on 3/17/23.
//

import SwiftUI

struct AddStudentToTrackView: View {
    @ObservedObject var data: HTTPClient
    var track: Track
    @Binding var dismiss: Bool // For dismiss
    @State private var isLoading = false
    
    var students: [Student] {
        let students = data.getStudentsForTrack(data: data, track: track)
        return students
    }
    
    var studentsForTrack: [Student] {
        let students = data.getStudentsForTrack(data: data, track: track)
        return students
    }
    
    var sessions: [Session] {
        let sessions = data.getSessionsForTrack(data: data, track: track)
        return sessions
    }
    
    private func createTrackStudent(student: Student) {
        self.isLoading = true
        // Check if a TrackStudent with the given track and student id already exists
        guard let existingTrackStudent = data.trackstudents.first(where: { $0.track_id == track.id && $0.student_id == student.id }) else {
            // Create a new TrackStudent
            let trackStudent = TrackStudent(id: UUID(), track_id: track.id, student_id: student.id)

            HTTPClient().createTrackStudent(id: trackStudent.id, track_id: track.id, student_id: student.id) { success in
                if success {
                    print("TrackStudent create successfully")
                    createAttendances(trackstudent_id: trackStudent.id)
                    self.data.readData()
                } else {
                    // show user the error message that save was not successful
                    print("Failed to create TrackStudent")
                }
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
            return
        }

        // If the TrackStudent already exists, print a message and call createAttendances
        print("TrackStudent already exists")
        createAttendances(trackstudent_id: existingTrackStudent.id)
        self.data.readData()
    }
    
    private func createAttendances(trackstudent_id: UUID) {
        let checkInTime = Date(timeIntervalSince1970: 0)
        let checkOutTime = Date(timeIntervalSince1970: 0)
        let hoursInSeconds: TimeInterval = 60 * 60
        
        for session in sessions {
            let date = session.date.addingTimeInterval(hoursInSeconds * 7)
            HTTPClient().createAttendance(trackstudent_id: trackstudent_id, date: date, sessionNumber: session.sessionNumber, checkInTime: checkInTime, checkOutTime: checkOutTime) { success in
                if success {
                    print("Attendance create successfully")
                    self.data.readData()
                } else {
                    // show user the error message that save was not successful
                    print("Failed to create Attendance")
                }
            }
        }
    }
    
    private func removeTrackStudent(student: Student) {
        self.isLoading = true
        guard let trackStudent = data.getTrackStudentForTrackAndStudent(data: data, track: track, student: student) else {
            return
        }
        HTTPClient().deleteTrackStudent(trackstudent: trackStudent) { success in
            if success {
                print("TrackStudent delete successfully")
                removeAttendances(trackstudent_id: trackStudent.id)
                self.data.readData()
            } else {
                // show user the error message that delete was not successful
                print("Failed to delete TrackStudent")
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
    
    private func removeAttendances(trackstudent_id: UUID) {
        
        let attendances = data.attendances.filter { $0.trackstudent_id == trackstudent_id }
        for attendance in attendances {
            HTTPClient().deleteAttendance(attendance: attendance) { success in
                if success {
                    print("Attendance delete successfully")
                    self.data.readData()
                } else {
                    print("Failed to delete Attendance")
                }
            }
        }
    }
    
    var body: some View {
        List {
            Text("All students added to the Track").bold() // For testing
            ForEach(students) { student in
                HStack {
                    Text(student.firstName)
                    Text(student.lastName)
                }
            }
            
            Text("All Students").bold()
            ForEach(data.students.indices, id: \.self) { index in
                let student = data.students[index]
                HStack {
                    Text(student.firstName)
                    Text(student.lastName)
                    Spacer()
                    
                    Button(action: {
                        if isLoading { // Make sure user can do nothing when isLoading
                            
                        } else {
                            if data.getTrackStudentForTrackAndStudent(data: data, track: track, student: student) != nil {
                                // Remove the student from the track
                                self.removeTrackStudent(student: student)
                                
                            } else {
                                // Add the student to the track
                                self.createTrackStudent(student: student)
                                
                            }
                        }
                        
                    }) {
                        if data.getTrackStudentForTrackAndStudent(data: data, track: track, student: student) != nil {
                            
                            if isLoading {
                                Text("Remove")
                                    .foregroundColor(.gray)
                            } else {
                                Text("Remove")
                                    .foregroundColor(.red)
                            }
                            
                        } else {
                            
                            if isLoading {
                                Text("Add")
                                    .foregroundColor(.gray)
                            } else {
                                Text("Add")
                            }
                            
                        }
                    }
                     
                }
            }
        }
        
    }
}

struct AddStudentToTrackView_Previews: PreviewProvider {
    static var previews: some View {
        let track = Track.example
        AddStudentToTrackView(data: HTTPClient(), track: track, dismiss: .constant(false))
    }
}

