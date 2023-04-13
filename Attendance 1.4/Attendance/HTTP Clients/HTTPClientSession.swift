//
//  HTTPClientSession.swift
//  Attendance
//
//  Created by 张熙景 on 4/6/23.
//

import Foundation

extension HTTPClient {
    
    // CRUD Operations for session
    func createSession(track_id: UUID, sessionNumber: String, date: Date, startTime: Date, endTime: Date, completion: @escaping (Bool) -> Void) {

        guard let url = URL(string: "http://192.168.0.219:8080/sessions") else {
            fatalError("URL is not defined!")
        }
        
        let session = Session(id: UUID(), track_id: track_id, sessionNumber: sessionNumber, date: date, startTime: startTime, endTime: endTime)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(session)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            completion(true)
        }.resume()
    }
        
    func readSession() {
        guard let url = URL(string: "http://192.168.0.219:8080/sessions") else {
            fatalError("URL is not defined!")
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            let sessions = try? JSONDecoder().decode([Session].self, from: data)
            if let sessions = sessions {
                DispatchQueue.main.async {
                    self.sessions = sessions
                }
            }
        }.resume()
    }
        
    func updateSession(_ session: Session, completion: @escaping (Bool) -> Void) {
        
        guard let url = URL(string: "http://192.168.0.219:8080/sessions/\(session.id)") else {
            fatalError("URL is not defined!")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(session)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            completion(true)
        }.resume()
    }
        
    func deleteSession(session: Session, completion: @escaping (Bool) -> Void) {
        
        let uuid = session.id
        guard let url = URL(string: "http://192.168.0.219:8080/session/\(uuid.uuidString)") else {
            fatalError("URL is not defined!")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            DispatchQueue.main.async {
                self.sessions.removeAll(where: { $0.id == uuid })
            }
            completion(true)
        }.resume()
    }
}
