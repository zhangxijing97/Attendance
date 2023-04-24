//
//  StudentDetailView.swift
//  Attendance 1.32
//
//  Created by Xijing Zhang on 3/17/23.
//

import SwiftUI

struct StudentDetailView: View {
    var student: Student
    
    var body: some View {
        
        List {
            Text("Name: \(student.name)")
            Text("Reference Number: \(student.referenceNumber)")
            Text("Gender: \(student.gender)")
            Text("Email Address: \(student.emailAddress)")
            Text("Phone Number: \(student.phoneNumber)")
            Text("Parent Name: \(student.parentName)")
            Text("Parent Phone Number: \(student.parentPhoneNumber)")
            Text("Additional Contact Phone Number: \(student.additionalContactPhoneNumber)")
        }
    }
}

//struct StudentDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudentDetailView()
//    }
//}
