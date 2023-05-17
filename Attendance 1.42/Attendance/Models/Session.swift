//
//  Session.swift
//  Attendance
//
//  Created by 张熙景 on 4/6/23.
//

import Foundation

struct Session: Codable, Identifiable { // Attendance model for one student enroll in one track
    var id: UUID
    var track_id: UUID
    var date: Date
    var sessionNumber: String
    var startTime: Date
    var endTime: Date
}
