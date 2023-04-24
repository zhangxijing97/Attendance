//
//  AddStudentView.swift
//  Attendance 1.32
//
//  Created by Xijing Zhang on 3/17/23.
//

import SwiftUI

struct AddStudentView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var referenceNumber = "987654321"
    @State private var name = "Jane Smith"
    @State private var gender = "N/A"
    @State private var emailAddress = "zhangxijing1124@gmail.com"
    @State private var phoneNumber = "555-555-1215"
    @State private var parentName = "John Smith"
    @State private var parentPhoneNumber = "555-555-1216"
    @State private var additionalContactPhoneNumber = "555-555-1217"
    let genders = ["N/A", "Female", "Male", "Intersex", "Trans", "Non-Conforming", "Personal", "Eunuch"]
    @State private var showingAlert = false // Alert
    
    private func createStudent() {
        HTTPClient().createStudent(referenceNumber: self.referenceNumber, name: self.name, gender: self.gender, emailAddress: self.emailAddress, phoneNumber: self.phoneNumber, parentName: self.parentName, parentPhoneNumber: self.parentPhoneNumber, additionalContactPhoneNumber: self.additionalContactPhoneNumber) { success in
            if success {
                // close the modal
                print("Student create successfully")
                HTTPClient().readData()
            } else {
                // show user the error message that save was not successful
                print("Failed to create student")
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Reference Number", text: $referenceNumber)
                    .keyboardType(.decimalPad)
                TextField("Name", text: $name)
                Picker("Gender", selection: $gender) {
                    ForEach(genders, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Email Address", text: $emailAddress)
                TextField("Phone Number", text: $phoneNumber)
                    .keyboardType(.decimalPad)
                TextField("Parent Name", text: $parentName)
                TextField("Parent Phone Number", text: $parentPhoneNumber)
                    .keyboardType(.decimalPad)
                TextField("Additional Contact Phone Number", text: $additionalContactPhoneNumber)
                    .keyboardType(.decimalPad)
                
                Button("Save") {
                    if  name == "" { // Make sure add something
                        showingAlert = true
                    } else {
                        self.createStudent()
                        HTTPClient().readData()
                        dismiss()
                    }
                }
                .alert("Please enter the information correctly", isPresented: $showingAlert) { // Alert code
                    Button("OK", role: .cancel) { }
                }
                
            }
            .navigationTitle("Add new Student")
//            .toolbar {
//                Button("Save") {
//                    if  name == "" { // Make sure add something
//                        showingAlert = true
//                    } else {
//                        self.createStudent()
//                        dismiss()
//                    }
//                }
//                .alert("Please enter the information correctly", isPresented: $showingAlert) { // Alert code
//                    Button("OK", role: .cancel) { }
//                }
//            }
        }
    }
}

struct AddMovieView_Previews: PreviewProvider {
    static var previews: some View {
        AddStudentView()
    }
}
