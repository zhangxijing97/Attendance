//
//  HTTPClientStudent.swift
//  Attendance
//
//  Created by 张熙景 on 4/6/23.
//

import Foundation

extension HTTPClient {
    
    // CRUD Operations for students
    func createStudent(name: String, emailAddress: String, referenceNumber: String, nickName: String, phoneNumber: String, gender: String, parentName: String, parentPhoneNumber: String, additionalContactPhoneNumber: String, completion: @escaping (Bool) -> Void) {
       
        guard let url = URL(string: "http://192.168.0.219:8080/students") else {
            fatalError("URL is not defined!")
        }
        
        let student = Student(id: UUID(), referenceNumber: referenceNumber, name: name, gender: gender, emailAddress: emailAddress, phoneNumber: phoneNumber, parentName: parentName, parentPhoneNumber: parentPhoneNumber, additionalContactPhoneNumber: additionalContactPhoneNumber)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(student)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            completion(true)
        }.resume()
    }
    
    func readStudent() {
        
        guard let url = URL(string: "http://192.168.0.219:8080/students") else {
            fatalError("URL is not defined!")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            let students = try? JSONDecoder().decode([Student].self, from: data)
            if let students = students {
                DispatchQueue.main.async {
                    self.students = students
                }
            }
        }.resume()
    }
    
    func updateStudent(_ student: Student, completion: @escaping (Bool) -> Void) {
        
        guard let url = URL(string: "http://192.168.0.219:8080/students/\(student.id)") else {
            fatalError("URL is not defined!")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(student)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            completion(true)
        }.resume()
    }
    
    func deleteStudent(student: Student, completion: @escaping (Bool) -> Void) {
        
        let uuid = student.id
        guard let url = URL(string: "http://192.168.0.219:8080/students/\(uuid.uuidString)") else {
            fatalError("URL is not defined!")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            DispatchQueue.main.async {
                self.students.removeAll(where: { $0.id == uuid })
            }
            completion(true)
        }.resume()
    }
}
