//
//  AddStudentView.swift
//  Attendance1.0
//
//  Created by 张熙景 on 2/2/23.
//

import SwiftUI

struct AddStudentView: View {
    @ObservedObject var data: AppData
    @Environment(\.dismiss) var dismiss // For dismiss the AddView
    
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
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Gender", selection: $gender) {
                    ForEach(genders, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Email Address", text: $emailAddress)
                TextField("Phone Number", text: $phoneNumber)
                    .keyboardType(.decimalPad)
                TextField("Reference Number", text: $referenceNumber)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new Student")
            .toolbar {
                Button("Save") {
                    if  name == "" { // Make sure add something
                        showingAlert = true
                    } else { let student = Student(name: name, emailAddress: emailAddress, referenceNumber: referenceNumber, nickName: nickName, phoneNumber: phoneNumber, gender: gender, parentName: parentName, parentPhoneNumber: parentPhoneNumber, additionalContactPhoneNumber: additionalContactPhoneNumber, trackIds: [])
                        data.students.append(student)
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

struct AddStudentView_Previews: PreviewProvider {
    static var previews: some View {
//        AddStudentView(students: StudentData())
        AddStudentView(data: AppData())
    }
}
