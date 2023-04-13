//
//  Track.swift
//  Attendance
//
//  Created by 张熙景 on 3/19/23.
//

import Foundation

struct Track: Codable, Identifiable {
    var id: UUID
    var name: String
    var level: String
    var location: String
    var date: String
    var sessions: [String]
    
    static let example = Track(id: UUID(uuidString: "F8641A53-3B34-4B3F-AB61-636F75E0B84A")!, name: "Track A", level: "Grades 6-9", location: "ASU Mesa MIX Center", date: "June 12 - 16, 9am to 4pm", sessions: ["Code for Games with Unity", "How Computers See"])
}
