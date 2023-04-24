//
//  HTTPClientAttendance.swift
//  Attendance
//
//  Created by 张熙景 on 4/6/23.
//

import Foundation

extension HTTPClient {
    
    // CRUD Operations for attendance
    func createAttendance(trackstudent_id: UUID, date: Date, sessionNumber: String, checkInTime: Date, checkOutTime: Date, completion: @escaping (Bool) -> Void) {

        guard let url = URL(string: "http://\(ipAddress):8080/attendances") else {
            fatalError("URL is not defined!")
        }
        
        let attendance = Attendance(id: UUID(), trackstudent_id: trackstudent_id, date: date, sessionNumber: sessionNumber, checkInTime: checkInTime, checkOutTime: checkOutTime)
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? encoder.encode(attendance)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            completion(true)
        }.resume()
    }
    
    func readAttendance() {
//        guard let url = URL(string: "http://192.168.0.219:8080/attendances") else {
        guard let url = URL(string: "http://\(ipAddress):8080/attendances") else {
            fatalError("URL is not defined!")
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            let attendances = try? decoder.decode([Attendance].self, from: data)
            if let attendances = attendances {
                DispatchQueue.main.async {
                    self.attendances = attendances
                }
            }
        }.resume()
    }
        
//    func updateAttendance(_ attendance: Attendance, completion: @escaping (Bool) -> Void) {
//
//        guard let url = URL(string: "http://\(ipAddress):8080/attendances/\(attendance.id)") else {
//            fatalError("URL is not defined!")
//        }
//
//        let encoder = JSONEncoder()
//        encoder.dateEncodingStrategy = .iso8601
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "PUT"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = try? encoder.encode(attendance)
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let _ = data, error == nil else {
//                return completion(false)
//            }
//            completion(true)
//        }.resume()
//    }
//
    func updateAttendance(_ attendance: Attendance, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://\(ipAddress):8080/attendances") else {
            fatalError("URL is not defined!")
        }
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? encoder.encode(attendance)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                completion(false)
                return
            }
            
            if httpResponse.statusCode != 200 {
                print("HTTP Error: \(httpResponse.statusCode)")
                completion(false)
                return
            }
            
            completion(true)
        }
        
        task.resume()
    }
        
    func deleteAttendance(attendance: Attendance, completion: @escaping (Bool) -> Void) {
        
        let uuid = attendance.id
//        guard let url = URL(string: "http://192.168.0.219:8080/attendances/\(uuid.uuidString)") else {
        guard let url = URL(string: "http://\(ipAddress):8080/attendances/\(uuid.uuidString)") else {
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
