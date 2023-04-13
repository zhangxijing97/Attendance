//
//  HTTPClientTrackStudent.swift
//  Attendance
//
//  Created by 张熙景 on 4/6/23.
//

import Foundation

extension HTTPClient {
    
    // CRUD Operations for trackstudent
    func createTrackStudent(track_id: UUID, student_id: UUID, completion: @escaping (Bool) -> Void) {

        guard let url = URL(string: "http://192.168.0.219:8080/trackstudents") else {
            fatalError("URL is not defined!")
        }

        let trackstudent = TrackStudent(id: UUID(), track_id: track_id, student_id: student_id)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(trackstudent)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            completion(true)
        }.resume()
    }
        
    func readTrackStudent() {
        
        guard let url = URL(string: "http://192.168.0.219:8080/trackstudents") else {
            fatalError("URL is not defined!")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            let trackstudents = try? JSONDecoder().decode([TrackStudent].self, from: data)
            if let trackstudents = trackstudents {
                DispatchQueue.main.async {
                    self.trackstudents = trackstudents
                }
            }
        }.resume()
    }
        
    func updateTrackStudent(_ trackstudent: TrackStudent, completion: @escaping (Bool) -> Void) {
        
        guard let url = URL(string: "http://192.168.0.219:8080/trackstudents/\(trackstudent.id)") else {
            fatalError("URL is not defined!")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(trackstudent)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            completion(true)
        }.resume()
    }
        
    func deleteTrackStudent(trackstudent: TrackStudent, completion: @escaping (Bool) -> Void) {
        
        let uuid = trackstudent.id
        guard let url = URL(string: "http://192.168.0.219:8080/trackstudent/\(uuid.uuidString)") else {
            fatalError("URL is not defined!")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            DispatchQueue.main.async {
                self.trackstudents.removeAll(where: { $0.id == uuid })
            }
            completion(true)
        }.resume()
    }
}
