//
//  Attendance.swift
//  Attendance
//
//  Created by 张熙景 on 3/19/23.
//

import Foundation

struct Attendance: Codable, Identifiable { // Attendance model for one student enroll in one track
    var id: UUID
    var trackstudent_id: UUID
    var date: Date
    var sessionNumber: String
    var checkInTime: Date
    var checkOutTime: Date
}
