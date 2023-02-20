//
//  Track.swift
//  Attendance1.0
//
//  Created by 张熙景 on 2/2/23.
//

import Foundation

class TrackData: ObservableObject { // ObservableObject mean could used more than one view
    @Published var tracks = [Track]() { // Changes the instance will trigger view reloads
        didSet { // Any time items is changed by anyone, our instance will be updated, take action when the value is modified
            if let encoded = try? JSONEncoder().encode(tracks) { // Use JSON(JavaScript Object Notation) encode
                UserDefaults.standard.set(encoded, forKey: "Tracks") // Set and save the data to storage
            }
        }
    }
    
    init() {
        if let savedTracks = UserDefaults.standard.data(forKey: "Tracks") { // Read the data from storage by UserDefaults
            if let decodedTracks = try? JSONDecoder().decode([Track].self, from: savedTracks) {
                tracks = decodedTracks // If that worked, assign the resulting array to items and exit.
                
                if tracks.isEmpty { // Load tracks.json to students
                    let loadTracks: [Track] = Bundle.main.decode("tracks.json")
                    tracks += loadTracks
                }
                return
            }
        }
        tracks = [] // Otherwise, set items to be an empty array
                    
    }
    
    func loadData() {
        if let savedTracks = UserDefaults.standard.data(forKey: "Tracks") { // Read the data from storage by UserDefaults
            if let decodedTracks = try? JSONDecoder().decode([Track].self, from: savedTracks) {
                tracks = decodedTracks // If that worked, assign the resulting array to items and exit.
                
                if tracks.isEmpty { // Load tracks.json to students
                    let loadTracks: [Track] = Bundle.main.decode("tracks.json")
                    tracks += loadTracks
                }
                return
            }
        }
        tracks = [] // Otherwise, set items to be an empty array
    }
}

struct Track: Codable, Identifiable {
    var id = UUID()
    var index: Int
    var name: String
    var level: String
    var location: String
    var date: String
    var days: [String]
    var sections: [String]
    var students: [StudentAttendance]
    
    var color: TrackColor
    var SectionAIcon: String
    var SectionAColor1: TrackColor
    var SectionAColor2: TrackColor
    var SectionBIcon: String
    var SectionBColor1: TrackColor
    var SectionBColor2: TrackColor

    static let allTracks: [Track] = Bundle.main.decode("tracks.json") // Example data
    static let example = allTracks[0]
}

struct StudentAttendance: Codable, Identifiable {
    var id = UUID()
    var name: String
    var sectionACourse1CheckInTime: String?
    var sectionACourse1CheckOutTime: String?
    var sectionBCourse1CheckInTime: String?
    var sectionBCourse1CheckOutTime: String?
    
    var sectionACourse2CheckInTime: String?
    var sectionACourse2CheckOutTime: String?
    var sectionBCourse2CheckInTime: String?
    var sectionBCourse2CheckOutTime: String?
    
    var sectionACourse3CheckInTime: String?
    var sectionACourse3CheckOutTime: String?
    var sectionBCourse3CheckInTime: String?
    var sectionBCourse3CheckOutTime: String?
    
    var sectionACourse4CheckInTime: String?
    var sectionACourse4CheckOutTime: String?
    var sectionBCourse4CheckInTime: String?
    var sectionBCourse4CheckOutTime: String?
    
    var sectionACourse5CheckInTime: String?
    var sectionACourse5CheckOutTime: String?
    var sectionBCourse5CheckInTime: String?
    var sectionBCourse5CheckOutTime: String?
}

struct TrackColor: Codable {
    var red: Double
    var green: Double
    var blue: Double
}
