//
//  HTTPClientTrack.swift
//  Attendance
//
//  Created by 张熙景 on 4/6/23.
//

import Foundation

extension HTTPClient {
    
    // Input track, get [TrackStudent]
    func getTrackStudentsForTrack(data: HTTPClient, track: Track) -> [TrackStudent] {
        let trackstudents = data.trackstudents.compactMap { trackstudent in
            if trackstudent.track_id == track.id {
                return trackstudent
            } else {
                return nil
            }
        }
        return trackstudents
    }

    // Input track, get [Student]
    func getStudentsForTrack(data: HTTPClient, track: Track) -> [Student] {
        let trackstudents = data.getTrackStudentsForTrack(data: data, track: track)
        let students = data.students.filter { student in
            return trackstudents.contains { trackstudent in
                trackstudent.student_id == student.id
            }
        }
        return students
    }
    
    // Input track and student, return TrackStudent
    func getTrackStudentForTrackAndStudent(data: HTTPClient, track: Track, student: Student) -> TrackStudent? {
        return data.trackstudents.first(where: { $0.track_id == track.id && $0.student_id == student.id })
    }
    
    // Input track, get [Session]
    func getSessionsForTrack(data: HTTPClient, track: Track) -> [Session] {
        let sessions = data.sessions // replace with your own implementation
        let sessionsForTrack = sessions.filter { $0.track_id == track.id }
        return sessionsForTrack
    }
    
    // Input student, get [TrackStudent]
    func getTrackStudentsForStudent(data: HTTPClient, student: Student) -> [TrackStudent] {
        let trackstudents = data.trackstudents.compactMap { trackstudent in
            if trackstudent.student_id == student.id {
                return trackstudent
            } else {
                return nil
            }
        }
        return trackstudents
    }

    // Input student, get [Track]
    func getTracksForStudent(data: HTTPClient, student: Student) -> [Track] {
        let trackstudents = data.getTrackStudentsForStudent(data: data, student: student)
        let tracks = data.tracks.filter { track in
            return trackstudents.contains { trackstudent in
                trackstudent.track_id == track.id
            }
        }
        return tracks
    }
    
    // Input session, get track
    func getTrackForSession(data: HTTPClient, session: Session) -> Track? {
        let tracks = data.tracks // replace with your own implementation
        let trackForSession = tracks.first { $0.id == session.track_id }
        return trackForSession
    }

    // Input trackstudent, get student
    func getStudentForTrackStudent(trackstudent: TrackStudent, students: [Student]) -> Student? {
        return students.first { $0.id == trackstudent.student_id }
    }

    // Input trackstudent, get track
    func getTrackForTrackStudent(trackstudent: TrackStudent, tracks: [Track]) -> Track? {
        return tracks.first { $0.id == trackstudent.track_id }
    }
}
