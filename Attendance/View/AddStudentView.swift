//
//  AddStudentView.swift
//  Attendance 1.32
//
//  Created by Xijing Zhang on 3/17/23.
//

import SwiftUI

struct AddStudentView: View {
//    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    @State private var referenceNumber = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var nickName = ""
    @State private var gender = ""
    @State private var pronouns = ""
    @State private var gradeEntering = ""
    
    
    @State private var emailAddress = ""
    @State private var phoneNumber = ""
    @State private var parentName = ""
    @State private var parentPhoneNumber = ""
    @State private var emergencyContactName1 = ""
    @State private var emergencyContactPhone1 = ""
    @State private var emergencyContactName2 = ""
    @State private var emergencyContactPhone2 = ""
    
    @State private var checkoutPolicy = ""
    @State private var other = ""
    let genders = ["N/A", "Female", "Male", "Intersex", "Trans", "Non-Conforming", "Personal", "Eunuch"]
    let pronounsList = ["N/A", "she/her/hers", "he/him/his", "they/them/theirs", "Ze/Hir/Hirs", "Xe/Xem/Xyrs", "Ey/Em/Eirs", "Fae/Faer/Faers", "Prefer not to disclose"]
    let gradeEnterings = ["N/A", "6th", "7th", "8th", "9th", "10th", "11th", "12th"]
    let checkoutPolicys = ["N/A", "Self-checkout", "Checkout required"]
    
    @State private var showingAlert = false // Alert
    
    private func createStudent() {
        HTTPClient().createStudent(referenceNumber: self.referenceNumber, firstName: self.firstName, lastName: self.lastName, nickName: self.nickName, gender: self.gender, pronouns: self.pronouns, gradeEntering: self.gradeEntering, emailAddress: self.emailAddress, phoneNumber: self.phoneNumber, parentName: self.parentName, parentPhoneNumber: self.parentPhoneNumber, emergencyContactName1: self.emergencyContactName1, emergencyContactPhone1: self.emergencyContactPhone1, emergencyContactName2: self.emergencyContactName2, emergencyContactPhone2: self.emergencyContactPhone2, checkoutPolicy: self.checkoutPolicy, other: self.other) { success in
                
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
            List {
                Section(header: Text("Personal Information")) {
                    TextField("Reference Number", text: $referenceNumber)
                        .keyboardType(.decimalPad)
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Nich Name", text: $nickName)
                    Picker("Gender", selection: $gender) {
                        ForEach(genders, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker("Pronouns", selection: $pronouns) {
                        ForEach(pronounsList, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker("Grade Entering", selection: $gradeEntering) {
                        ForEach(gradeEnterings, id: \.self) {
                            Text($0)
                        }
                    }
                    
                }
                
                Section(header: Text("Contact Information")) {
                    TextField("Email Address", text: $emailAddress)
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Parent Information")) {
                    TextField("Parent Name", text: $parentName)
                    TextField("Parent Phone Number", text: $parentPhoneNumber)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Emergency Contact Information")) {
                    TextField("Emergency Contact Name 1", text: $emergencyContactName1)
                    TextField("Emergency Contact Phone 1", text: $emergencyContactPhone1)
                        .keyboardType(.decimalPad)
                    TextField("Emergency Contact Name 2", text: $emergencyContactName2)
                    TextField("Emergency Contact Phone 2", text: $emergencyContactPhone2)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Emergency Contact Information")) {
                    Picker("Checkout Policy", selection: $checkoutPolicy) {
                        ForEach(checkoutPolicys, id: \.self) {
                            Text($0)
                        }
                    }
                    TextField("Other", text: $other)
                }
            }
            .navigationBarTitle("Add Student", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                self.presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Save") {
                if lastName == "" || firstName == "" { // Make sure add something
                    showingAlert = true
                } else {
                    self.createStudent()
                    HTTPClient().readData()
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
                .alert("Please enter the information correctly", isPresented: $showingAlert) { // Alert code
                    Button("OK", role: .cancel) { }
                }
            )
            
        }
    }
}

struct AddMovieView_Previews: PreviewProvider {
    static var previews: some View {
        AddStudentView()
    }
}
