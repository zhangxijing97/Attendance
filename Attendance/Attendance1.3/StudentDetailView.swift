//
//  StudentDetailView.swift
//  Attendance1.0
//
//  Created by 张熙景 on 2/6/23.
//

import SwiftUI

struct StudentDetailView: View {
    @Binding var student: Student
    @ObservedObject var students = StudentData()
    @ObservedObject var trackData = TrackData()
    
    var body: some View {
        List {
            
            Section {
                Text("id: ").bold() + Text("\(student.id)" as String)
                Text("Name: ").bold() + Text(student.name)
                Text("Email Address: ").bold() + Text(student.emailAddress)
                Text("Nick Name: ").bold() + Text(student.nickName)
                Text("Phone Number: ").bold() + Text(student.phoneNumber)
                Text("Parent's Name: ").bold() + Text(student.parentName)
                Text("Parent's Phone Number: ").bold() + Text(student.parentPhoneNumber)
                
//                Text("Name: \(student.name)")
//                Text("Email Address: \(student.emailAddress)")
//                Text("Nick Name: \(student.nickName)")
//                Text("Phone Number: \(student.phoneNumber)")
//                Text("Parent's Name: \(student.parentName)")
//                Text("Parent's Phone Number: \(student.parentPhoneNumber)")
            }
            
            Text("All Tracks").bold()
            ForEach(0..<student.tracks.count, id: \.self) { index in // student.track
                HStack {
                    Toggle(isOn: $student.tracks[index]) {
                        Text("Track \(String(Character(UnicodeScalar(index + 65)!)).uppercased())")
                        Text("\(student.tracks[index])" as String)
                    }

//                    Button("Save") {
////                        let student = student.name
//                        let student = [studentAttendance(id: student.id, name: student.name, checkInTime: "", checkOutTime: "")]
//                        if !self.trackData.tracks[index].students.contains(student) {
//                            let countBefore = trackData.tracks[index].students.count
//                            trackData.tracks[index].students.append(student)
//                            let countAfter = trackData.tracks[index].students.count
//                            if countAfter > countBefore {
//                                print("Student added successfully")
//                            } else {
//                                print("Adding student failed")
//                            }
//                        }
//                    }
                    
                }
            }
            
            Text("All students added").bold() // For testing
            ForEach(student.tracks, id: \.self) { track in // track.student
                HStack {
                    Text("\(track)" as String)
                }
            }
            
        }
    }
}

struct StudentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let student = Student.example
        return StudentDetailView(student: .constant(student))
    }
}
