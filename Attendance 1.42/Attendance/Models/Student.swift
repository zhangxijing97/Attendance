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
    var firstName: String
    var lastName: String
    var nickName: String
    var gender: String
    var pronouns: String
    var gradeEntering: String
    
    var emailAddress: String
    var phoneNumber: String
    var parentName: String
    var parentPhoneNumber: String
    var emergencyContactName1: String
    var emergencyContactPhone1: String
    var emergencyContactName2: String
    var emergencyContactPhone2: String
    
    var checkoutPolicy: String
    var other: String
}
