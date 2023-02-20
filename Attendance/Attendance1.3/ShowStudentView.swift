//
//  ShowStudentView.swift
//  Attendance1.0
//
//  Created by 张熙景 on 2/3/23.
//

import SwiftUI

struct ShowStudentView: View {
    var track: Track
    @ObservedObject var students = StudentData()
    @ObservedObject var trackData = TrackData()
    @Binding var dismiss: Bool // For dismiss
    
    var body: some View {
        List {
//            Text("\(track.index)" as String) // For testing
            
            Text("All students added").bold() // For testing
            ForEach(track.students) { student in // track.student
                HStack {
                    Text(student.name)
                }
            }
            
            Text("All Students").bold()
            ForEach(0..<students.students.count, id: \.self) { index in // student.track
                HStack {
                    Toggle(isOn: $students.students[index].tracks[track.index]) {
                        Text(students.students[index].name)
                        Text("\(students.students[index].tracks[track.index])" as String)
                    }
                    .onTapGesture {
                        withAnimation {
                            let student = StudentAttendance(id: students.students[index].id, name: students.students[index].name)
                            // Add students to trackData.tracks[track.index].students
                            if students.students[index].tracks[track.index] == false && !self.trackData.tracks[track.index].students.contains(where: { $0.id == student.id }) {
                                let countBefore = trackData.tracks[track.index].students.count
                                trackData.tracks[track.index].students.append(student)
                                let countAfter = trackData.tracks[track.index].students.count
                                if countAfter > countBefore {
                                    print("Student added successfully")
                                } else {
                                    print("Student added failed")
                                }
                                // Remove students from trackData.tracks[track.index].students
                            } else if students.students[index].tracks[track.index] == true && self.trackData.tracks[track.index].students.contains(where: { $0.id == student.id }) {
                                let countBefore = trackData.tracks[track.index].students.count
                                if let studentIndex = trackData.tracks[track.index].students.firstIndex(where: { $0.id == student.id }) {
                                    trackData.tracks[track.index].students.remove(at: studentIndex)
                                }
                                let countAfter = trackData.tracks[track.index].students.count
                                if countAfter < countBefore {
                                    print("Student removed successfully")
                                } else {
                                    print("Student removed failed")
                                }
                            } else {
                                print("Error")
                            }
                            students.students[index].tracks[track.index].toggle()                         
                        }
                    }
                    
                }
            }
            
            Button {
                dismiss.toggle()
            } label: {
                Text("Complete")
            }
            
        }
    }
}

struct ShowStudentView_Previews: PreviewProvider {
    static var previews: some View {
        ShowStudentView(track: Track.example, students: StudentData(), trackData: TrackData(), dismiss: .constant(false))
    }
}

