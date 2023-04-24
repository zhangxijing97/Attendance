//
//  Student.swift
//  Attendance
//
//  Created by Xijing Zhang on 3/19/23.
//

import Foundation

struct Student: Codable, Identifiable {
    var id: UUID
    var referenceNumber: String
    var name: String
    var gender: String
    var emailAddress: String
    var phoneNumber: String
    var parentName: String
    var parentPhoneNumber: String
    var additionalContactPhoneNumber: String
}
