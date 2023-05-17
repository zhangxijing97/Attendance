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
        NavigationView {
            List {
                Section(header: Text("Personal Information")) {
                    Text("Reference Number: \(student.referenceNumber)")
                    Text("Name: \(student.firstName)\(student.lastName)")
                    Text("Nick Name: \(student.nickName)")
                    Text("Gender: \(student.gender)")
                    Text("Pronouns: \(student.pronouns)")
                    Text("Grade Entering: \(student.gradeEntering)")
                }
                
                Section(header: Text("Contact Information")) {
                    Text("Email Address: \(student.emailAddress)")
                    Text("Phone Number: \(student.phoneNumber)")
                }
                
                Section(header: Text("Parent Information")) {
                    Text("Parent Name: \(student.parentName)")
                    Text("Parent Phone Number: \(student.phoneNumber)")
                }
                
                Section(header: Text("Emergency Contact Information")) {
                    Text("Emergency Contact Name 1: \(student.emergencyContactName1)")
                    Text("Emergency Contact Phone 1: \(student.emergencyContactPhone1)")
                    Text("Emergency Contact Name 2: \(student.emergencyContactName2)")
                    Text("Emergency Contact Phone 2: \(student.emergencyContactPhone2)")
                }
                
                Section(header: Text("Policies and Other Information")) {
                    Text("Checkout Policy: \(student.checkoutPolicy)")
                    Text("Other: \(student.other)")
                }
                
            }
            .navigationBarTitle("Student Profile", displayMode: .inline)
        }
    }
}

//struct StudentDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudentDetailView()
//    }
//}
