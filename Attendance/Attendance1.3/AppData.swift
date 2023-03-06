//
//  Track.swift
//  Attendance1.0
//
//  Created by 张熙景 on 2/2/23.
//

import Foundation

class AppData: ObservableObject {
    @Published var tracks = [Track]() {
        didSet {
            saveTracks()
        }
    }
    
    @Published var students = [Student]() {
        didSet {
            saveStudents()
        }
    }
    
    @Published var attendances = [Attendance]() {
        didSet {
            saveAttendances()
        }
    }
    
    init() {
        loadTracks()
        loadStudents()
        loadAttendances()
    }
    
    func loadTracks() {
        if let savedTracks = UserDefaults.standard.data(forKey: "Tracks") {
            if let decodedTracks = try? JSONDecoder().decode([Track].self, from: savedTracks) {
                tracks = decodedTracks
            }
        }
        let loadTracks: [Track] = Bundle.main.decode("tracks.json")
        for track in loadTracks { // Check if the student with the same id already exists in students
            if !tracks.contains(where: { $0.id == track.id }) {
                tracks.append(track)
            }
        }
    }
    
    func loadStudents() {
        if let savedStudents = UserDefaults.standard.data(forKey: "Students") {
            if let decodedStudents = try? JSONDecoder().decode([Student].self, from: savedStudents) {
                students = decodedStudents
            }
        }
        let loadStudents: [Student] = Bundle.main.decode("students.json")
        for student in loadStudents { // Check if the student with the same id already exists in students
            if !students.contains(where: { $0.id == student.id }) {
                students.append(student)
            }
        }
    }
    
    func loadAttendances() {
        if let savedAttendances = UserDefaults.standard.data(forKey: "Attendances") {
            if let decodedAttendances = try? JSONDecoder().decode([Attendance].self, from: savedAttendances) {
                attendances = decodedAttendances
            }
        }
    }

    func saveTracks() {
        if let encoded = try? JSONEncoder().encode(tracks) {
            UserDefaults.standard.set(encoded, forKey: "Tracks")
        }
    }
    
    func saveStudents() {
        if let encoded = try? JSONEncoder().encode(students) {
            UserDefaults.standard.set(encoded, forKey: "Students")
        }
    }
    
    func saveAttendances() {
        if let encoded = try? JSONEncoder().encode(attendances) {
            UserDefaults.standard.set(encoded, forKey: "Attendances")
        }
    }
    
    func addAttendance(student: Student, track: Track) {
        let checkInDate = Date(timeIntervalSince1970: 0)
        let checkOutDate = Date(timeIntervalSince1970: 0)
        let session = Session(checkInTime: checkInDate, checkOutTime: checkOutDate)
        let attendance = Attendance(trackId: track.id, studentId: student.id, day1Sessions: [session, session], day2Sessions: [session, session], day3Sessions: [session, session], day4Sessions: [session, session], day5Sessions: [session, session])
        attendances.append(attendance)
        let countAfter = attendances.count
        print("attendances: \(countAfter)")
    }
    
    func removeAttendance(student: Student, track: Track) {
        attendances.removeAll(where: { $0.studentId == student.id && $0.trackId == track.id })
        let countAfter = attendances.count
        print("attendances: \(countAfter)")
    }
}

struct Track: Codable, Identifiable {
    var id: UUID
    var index: Int
    var name: String
    var level: String
    var location: String
    var date: String
    var days: [String]
    var sections: [String]
    var studentIds: [UUID]
    
    var color: TrackColor
    var SectionAIcon: String
    var SectionAColor1: TrackColor
    var SectionAColor2: TrackColor
    var SectionBIcon: String
    var SectionBColor1: TrackColor
    var SectionBColor2: TrackColor
    
    mutating func addStudent(student: Student) { // Add student object to Track object
        studentIds.append(student.id)
        let countAfter = studentIds.count
        print("students of track: \(countAfter)")
    }
    
    mutating func removeStudent(student: Student) {
        studentIds.removeAll(where: { $0 == student.id })
        let countAfter = studentIds.count
        print("students of track: \(countAfter)")
    }
    
    func getStudents(track: Track, data: AppData) -> [Student] { // Return Student instance array of the Track
        return data.students.filter { student in
            track.studentIds.contains(student.id)
        }
    }
    
    func attendance(student: Student, data: AppData) -> Attendance? { // Return Attendance instance of the student for the Track
        return data.attendances.first { attendance in attendance.trackId == id && attendance.studentId == student.id } // Both trackId and studentId correct
    }
    
    func getAttendances(data: AppData) -> [Attendance] { // Return Attendance instance array of the Track
        let attendances = data.attendances.compactMap { attendance in
            if attendance.trackId == id {
                return attendance
            } else {
                return nil
            }
        }
        return attendances
    }

    static let allTracks: [Track] = Bundle.main.decode("tracks.json") // Example data
    static let example = allTracks[0]
}

struct TrackColor: Codable {
    var red: Double
    var green: Double
    var blue: Double
}

struct Student: Identifiable, Codable { // This type can be identified uniquely
    var id = UUID()
    var name: String
    var emailAddress: String
    var referenceNumber: String
    var nickName: String
    var phoneNumber: String
    var gender: String
    var parentName: String
    var parentPhoneNumber: String
    var additionalContactPhoneNumber: String
    var trackIds: [UUID]
    
    mutating func addTrack(track: Track) {
        trackIds.append(track.id)
        let countAfter = trackIds.count
        print("tracks of one student: \(countAfter)")
    }
    
    mutating func removeTrack(track: Track) {
        trackIds.removeAll(where: { $0 == track.id })
        let countAfter = trackIds.count
        print("tracks of one student:: \(countAfter)")
    }

    static let allStudents: [Student] = Bundle.main.decode("students.json") // Example data
    static let example = allStudents[0]
}

struct Attendance: Identifiable, Codable { // Attendance model for one student enroll in one track
    var id = UUID()
    var trackId: UUID
    var studentId: UUID
    
    var day1Sessions: [Session]
    var day2Sessions: [Session]
    var day3Sessions: [Session]
    var day4Sessions: [Session]
    var day5Sessions: [Session]
    
    func studentName(attendance: Attendance) -> String? { // Return Student.name match studentId
        let matchingStudents = Student.allStudents.filter { $0.id == attendance.studentId }
        guard let student = matchingStudents.first else {
            return nil // No matching student found
        }
        return student.name
    }
}

struct Session: Codable {
    var checkInTime: Date
    var checkOutTime: Date
}
