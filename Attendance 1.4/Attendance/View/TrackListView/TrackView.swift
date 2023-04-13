//
//  TrackView.swift
//  Attendance 1.32
//
//  Created by Xijing Zhang on 3/17/23.
//

import SwiftUI

struct TrackView: View {
    @ObservedObject var data: HTTPClient
    var track: Track

    var studentsNumberInTrack: Int {
        let trackstudents = data.getTrackStudentForTrack(data: data, track: track)
        let NumberInTrack = trackstudents.count
        return NumberInTrack
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
                .frame(height: 16)
            
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    Text("Total")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                    Spacer()
                        .frame(height: 38)
                    Text("\(studentsNumberInTrack)" as String)
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                    Spacer()
                }
                .frame(width: 108)
                
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(track.sessions, id: \.self) { session in
                        SessionView(data: data, track: track, session: session)
                        Spacer()
                            .frame(height: 20)
                    }
                }
                Spacer()
                    .frame(width: 18)
            }
            .frame(height: 155)

            Rectangle()
                .fill(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                .opacity(0.2)
                .frame(height: 1)
            HStack {
                Image(systemName: "square.stack.3d.up.badge.a.fill")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                Text(track.name)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
            }
            .padding(.leading, 18)
            .frame(height: 40)
            
        }
    }
}

struct TrackView_Previews: PreviewProvider {
    static var previews: some View {
        let track = Track.example
        TrackView(data: HTTPClient(), track: track)
    }
}
