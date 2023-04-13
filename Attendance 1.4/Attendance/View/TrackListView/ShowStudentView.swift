//
//  ShowStudentView.swift
//  Attendance 1.32
//
//  Created by Xijing Zhang on 3/17/23.
//

import SwiftUI

struct ShowStudentView: View {
    @Binding var track: Track
//    @ObservedObject var data: AppData
    @ObservedObject var data: HTTPClient
    
    @Binding var dismiss: Bool // For dismiss
    
    var students: [Student] {
        let students = data.getStudentForTrack(data: data, track: track)
        return students
    }
    
    var body: some View {
        List {
//            Text("\(track.index)" as String) // For testing
            
            Text("All students added to the Track").bold() // For testing
            ForEach(students) { student in
                HStack {
                    Text(student.name)
                }
            }
            
            Text("All Students").bold()
            ForEach(data.students.indices, id: \.self) { index in
                let student = data.students[index]
                HStack {
                    Text(student.name)
                    Spacer()
                    Button(action: {
                            if track.attendance(student: student, data: data) != nil {
                                track.removeStudent(student: student)
                                data.students[index].removeTrack(track: track)
                                data.removeAttendance(student: student, track: track)
                            } else {
                                track.addStudent(student: student)
                                data.students[index].addTrack(track: track)
                                data.addAttendance(student: student, track: track)
                            }
                        }) {
                            if track.attendance(student: student, data: data) != nil {
                                Text("Remove")
                                    .foregroundColor(.red)
                            } else {
                                Text("Add")
                            }
                    }
                }
            }
        }
    }
}

struct ShowStudentView_Previews: PreviewProvider {
    static var previews: some View {
        let track = Track.example
        ShowStudentView(track: .constant(track), data: HTTPClient(), dismiss: .constant(false))
    }
}

