//
//  HTTPClientTrack.swift
//  Attendance
//
//  Created by 张熙景 on 4/6/23.
//

import Foundation

extension HTTPClient {
    
    // CRUD Operations for tracks
    func createTrack(id: UUID, name: String, level: String, location: String, startDate: Date, endDate: Date, sessions: [String], completion: @escaping (Bool) -> Void) {
        
//        guard let url = URL(string: "http://192.168.0.219:8080/tracks") else {
            guard let url = URL(string: "http://\(ipAddress):8080/tracks") else {
            fatalError("URL is not defined!")
        }
        
        let track = Track(id: id, name: name, level: level, location: location, startDate: startDate, endDate: endDate, sessions: sessions)
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? encoder.encode(track)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            completion(true)
        }.resume()
    }

    func readTrack() {
        
//        guard let url = URL(string: "http://192.168.0.219:8080/tracks") else {
        guard let url = URL(string: "http://\(ipAddress):8080/tracks") else {
            fatalError("URL is not defined!")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let tracks = try? decoder.decode([Track].self, from: data)
            if let tracks = tracks {
                DispatchQueue.main.async {
                    self.tracks = tracks
                }
            }
        }.resume()
    }

    func updateTrack(_ track: Track, completion: @escaping (Bool) -> Void) {
        
//        guard let url = URL(string: "http://192.168.0.219:8080/tracks/\(track.id)") else {
        guard let url = URL(string: "http://\(ipAddress):8080/tracks/\(track.id)") else {
            fatalError("URL is not defined!")
        }
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? encoder.encode(track)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            completion(true)
        }.resume()
    }

    func deleteTrack(track: Track, completion: @escaping (Bool) -> Void) {
        
        let uuid = track.id
//        guard let url = URL(string: "http://192.168.0.219:8080/tracks/\(uuid.uuidString)") else {
        guard let url = URL(string: "http://\(ipAddress):8080/tracks/\(uuid.uuidString)") else {
            fatalError("URL is not defined!")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            DispatchQueue.main.async {
                self.tracks.removeAll(where: { $0.id == uuid })
            }
            completion(true)
        }.resume()
    }
}
