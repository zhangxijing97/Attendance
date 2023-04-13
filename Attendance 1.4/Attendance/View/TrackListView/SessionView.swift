//
//  SessionView.swift
//  Attendance
//
//  Created by 张熙景 on 3/19/23.
//

import SwiftUI

struct SessionView: View {
    @ObservedObject var data: HTTPClient
    
    var track: Track
    var session: String
    
    var studentsNumberInTrack: Int {
        let trackstudents = data.getTrackStudentForTrack(data: data, track: track)
        let NumberInTrack = trackstudents.count
        return NumberInTrack
    }
    
//    var attendanceNumberInTrack: Int {
//        let NumberInTrack = data.attendanceNumberInTrack(track: track, checkTime: <#T##Date#>)
//        return NumberInTrack
//    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text("< ")
                Text(session)
                Text(" >")
            }
            Spacer()
                .frame(height: 10)
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("Check In:")
                        Spacer()
                        Text("8/23")
                    }
                    Spacer()
                        .frame(height: 10)
                    ProgressBarView()
                }
                .frame(width: 120)
                Spacer()
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("Check Out:")
                        Spacer()
                        Text("8/23")
                    }
                    Spacer()
                        .frame(height: 10)
                    ProgressBarView()
                }
                .frame(width: 120)
            }
        }
        .font(.system(size: 14, weight: .medium, design: .rounded))
        .foregroundColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        let track = Track.example
        let session = "Introduction to Audio Production"
        SessionView(data: HTTPClient(), track: track, session: session)
    }
}
