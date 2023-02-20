//
//  Student.swift
//  Attendance1.0
//
//  Created by 张熙景 on 1/31/23.
//

import Foundation

class StudentData: ObservableObject { // ObservableObject mean could used more than one view
    @Published var students = [Student]() { // Changes the instance will trigger view reloads
        didSet { // Any time items is changed by anyone, our instance will be updated, take action when the value is modified 
            if let encoded = try? JSONEncoder().encode(students) { // Use JSON(JavaScript Object Notation) encode
                UserDefaults.standard.set(encoded, forKey: "Students") // Set and save the data to storage
            }
        }
    }
    
    init() {
        if let savedStudents = UserDefaults.standard.data(forKey: "Students") { // Read the data from storage by UserDefaults
            if let decoded = try? JSONDecoder().decode([Student].self, from: savedStudents) { // Convert the data to array of decodedClassArray objects
                students = decoded // If that worked, assign the resulting array to items and exit.
                
                if students.isEmpty { // Load tracks.json to students
                    let loadStudents: [Student] = Bundle.main.decode("students.json") // Load students.json to students
                    students += loadStudents
                }
                return
            }
        }
        students = [] // Otherwise, set items to be an empty array
    }
    
    func loadData() {
        if let savedStudents = UserDefaults.standard.data(forKey: "Students") { // Read the data from storage by UserDefaults
            if let decoded = try? JSONDecoder().decode([Student].self, from: savedStudents) { // Convert the data to array of decodedClassArray objects
                students = decoded // If that worked, assign the resulting array to items and exit.
                
                if students.isEmpty { // Load tracks.json to students
                    let loadStudents: [Student] = Bundle.main.decode("students.json") // Load students.json to students
                    students += loadStudents
                }
                return
            }
        }
        students = [] // Otherwise, set items to be an empty array
    }
}

struct Student: Identifiable, Codable { // This type can be identified uniquely
    var id = UUID() // UUID(universally unique identifier), "UUID()" ask Swift to generate a UUID automatically for us
    var name: String
    var emailAddress: String
    var referenceNumber: String
    var nickName: String
    var phoneNumber: String
    var gender: String
    var parentName: String
    var parentPhoneNumber: String
    var additionalContactPhoneNumber: String
    var attendance: Bool
    var tracks: [Bool]

    static let allStudents: [Student] = Bundle.main.decode("students.json") // Example data
    static let example = allStudents[0]
}
