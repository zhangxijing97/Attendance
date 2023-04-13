//
//  AddStudentView.swift
//  Attendance 1.32
//
//  Created by Xijing Zhang on 3/17/23.
//

import SwiftUI

struct AddStudentView: View {

    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var gender = "N/A"
    @State private var emailAddress = ""
    @State private var referenceNumber = ""
    @State private var nickName = ""
    @State private var phoneNumber = ""
    @State private var parentName = ""
    @State private var parentPhoneNumber = ""
    @State private var additionalContactPhoneNumber = ""
    let genders = ["N/A", "Female", "Male", "Intersex", "Trans", "Non-Conforming", "Personal", "Eunuch"]
    @State private var showingAlert = false // Alert
    
    private func createStudent() {
        HTTPClient().createStudent(name: self.name, emailAddress: self.emailAddress, referenceNumber: self.referenceNumber, nickName: self.nickName, phoneNumber: self.phoneNumber, gender: self.gender, parentName: self.parentName, parentPhoneNumber: self.parentPhoneNumber, additionalContactPhoneNumber: self.additionalContactPhoneNumber) { success in
            if success {
                // close the modal
                print("Student create successfully")
            } else {
                // show user the error message that save was not successful
                print("Failed to create student")
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Reference Number", text: $referenceNumber)
                    .keyboardType(.decimalPad)
                Picker("Gender", selection: $gender) {
                    ForEach(genders, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Email Address", text: $emailAddress)
                TextField("Phone Number", text: $phoneNumber)
                    .keyboardType(.decimalPad)
                TextField("Nick Name", text: $nickName)
                TextField("Parent Name", text: $parentName)
                TextField("Parent Phone Number", text: $parentPhoneNumber)
                    .keyboardType(.decimalPad)
                TextField("Additional Contact Phone Number", text: $additionalContactPhoneNumber)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new Student")
            .toolbar {
                Button("Save") {
                    if  name == "" { // Make sure add something
                        showingAlert = true
                    } else {
                        self.createStudent()
                        dismiss()
                    }
                }
                .alert("Please enter the information correctly", isPresented: $showingAlert) { // Alert code
                    Button("OK", role: .cancel) { }
                }
            }
        }
    }
}

//struct AddStudentView: View {
//    @ObservedObject var data: AppData
//    @Environment(\.dismiss) var dismiss // For dismiss the AddView
//
//    @State private var name = ""
//    @State private var gender = "N/A"
//    @State private var emailAddress = ""
//    @State private var referenceNumber = ""
//    @State private var nickName = ""
//    @State private var phoneNumber = ""
//    @State private var parentName = ""
//    @State private var parentPhoneNumber = ""
//    @State private var additionalContactPhoneNumber = ""
//    let genders = ["N/A", "Female", "Male", "Intersex", "Trans", "Non-Conforming", "Personal", "Eunuch"]
//    @State private var showingAlert = false // Alert
//
//    var body: some View {
//        NavigationView {
//            Form {
//                TextField("Name", text: $name)
//                Picker("Gender", selection: $gender) {
//                    ForEach(genders, id: \.self) {
//                        Text($0)
//                    }
//                }
//                TextField("Email Address", text: $emailAddress)
//                TextField("Phone Number", text: $phoneNumber)
//                    .keyboardType(.decimalPad)
//                TextField("Reference Number", text: $referenceNumber)
//                    .keyboardType(.decimalPad)
//            }
//            .navigationTitle("Add new Student")
//            .toolbar {
//                Button("Save") {
//                    if  name == "" { // Make sure add something
//                        showingAlert = true
//                    } else { let student = Student(name: name, emailAddress: emailAddress, referenceNumber: referenceNumber, nickName: nickName, phoneNumber: phoneNumber, gender: gender, parentName: parentName, parentPhoneNumber: parentPhoneNumber, additionalContactPhoneNumber: additionalContactPhoneNumber, trackIds: [])
//                        data.students.append(student)
//                        dismiss()
//                    }
//                }
//                .alert("Please enter the information correctly", isPresented: $showingAlert) { // Alert code
//                    Button("OK", role: .cancel) { }
//                }
//            }
//        }
//    }
//}

struct AddStudentView_Previews: PreviewProvider {
    static var previews: some View {
//        AddStudentView(students: StudentData())
        AddStudentView()
    }
}
