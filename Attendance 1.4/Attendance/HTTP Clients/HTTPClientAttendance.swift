//
//  HTTPClientAttendance.swift
//  Attendance
//
//  Created by 张熙景 on 4/6/23.
//

import Foundation

extension HTTPClient {
    
    // CRUD Operations for attendance
    func createAttendance(trackstudent_id: UUID, sessionNumber: String, date: Date, checkInTime: Date, checkOutTime: Date, completion: @escaping (Bool) -> Void) {

        guard let url = URL(string: "http://192.168.0.219:8080/attendances") else {
            fatalError("URL is not defined!")
        }
        
        let attendance = Attendance(id: UUID(), trackstudent_id: trackstudent_id, date: date, sessionNumber: sessionNumber, checkInTime: checkInTime, checkOutTime: checkOutTime)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(attendance)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            completion(true)
        }.resume()
    }
        
    func readAttendance() {
        guard let url = URL(string: "http://192.168.0.219:8080/attendances") else {
            fatalError("URL is not defined!")
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            let attendances = try? JSONDecoder().decode([Attendance].self, from: data)
            if let attendances = attendances {
                DispatchQueue.main.async {
                    self.attendances = attendances
                }
            }
        }.resume()
    }
        
    func updateAttendance(_ attendance: Attendance, completion: @escaping (Bool) -> Void) {
        
        guard let url = URL(string: "http://192.168.0.219:8080/attendances/\(attendance.id)") else {
            fatalError("URL is not defined!")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(attendance)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            completion(true)
        }.resume()
    }
        
    func deleteAttendance(attendance: Attendance, completion: @escaping (Bool) -> Void) {
        
        let uuid = attendance.id
        guard let url = URL(string: "http://192.168.0.219:8080/attendances/\(uuid.uuidString)") else {
            fatalError("URL is not defined!")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            DispatchQueue.main.async {
                self.attendances.removeAll(where: { $0.id == uuid })
            }
            completion(true)
        }.resume()
    }
}
