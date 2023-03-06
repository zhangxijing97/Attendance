//
//  StudentDetailView.swift
//  Attendance1.0
//
//  Created by 张熙景 on 2/6/23.
//

import SwiftUI

struct StudentDetailView: View {
    @Binding var student: Student
    @ObservedObject var data: AppData
    
    var body: some View {
        List {
            Section {
                Text("id: ").bold() + Text("\(student.id)" as String)
                Text("Name: ").bold() + Text(student.name)
                HStack{
                    Text("Name: ").bold()
                    TextField("Enter your name", text: $student.name)
                }
                Text("Email Address: ").bold() + Text(student.emailAddress)
                Text("Nick Name: ").bold() + Text(student.nickName)
                Text("Phone Number: ").bold() + Text(student.phoneNumber)
                Text("Parent's Name: ").bold() + Text(student.parentName)
                Text("Parent's Phone Number: ").bold() + Text(student.parentPhoneNumber)
            }
            
            Text("All Tracks").bold()
            ForEach(student.trackIds, id: \.self) { id in
                Text("\(id)" as String)
            }
        }
    }
}

struct StudentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StudentDetailView(student: .constant(Student.example), data: AppData())
    }
}
