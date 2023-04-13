//
//  TrackStudent.swift
//  Attendance
//
//  Created by Xijing Zhang on 4/2/23.
//

import Foundation

struct TrackStudent: Codable, Identifiable {
    var id: UUID
    var track_id: UUID
    var student_id: UUID
}

