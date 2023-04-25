//
//  TrackListView.swift
//  Attendance
//
//  Created by 张熙景 on 3/19/23.
//

import SwiftUI

struct TrackListView: View {
    @ObservedObject var data: HTTPClient
    @State private var isTrackDetailViewPresented = false
    @State private var selectedTrack: Track?
    
    // Get selectedDate
    var selectedDate: Date {
        return data.selectedDate
    }
    
    // Get tracks
    private func tracks() -> [Track]? {
        let tracks = data.tracks
        return tracks
    }
    
    // Get all tracks match the date
    private func tracksForDate() -> [Track]? {
        guard let tracks = tracks() else { return nil }
        let formatter = DateFormatter()
        let tracksForDate = tracks.filter { track in
            let hoursInSeconds: TimeInterval = 60 * 60
            let startDateWithOffset = track.startDate.addingTimeInterval(hoursInSeconds * 7)
            let endDateWithOffset = track.endDate.addingTimeInterval(hoursInSeconds * 7)
            return startDateWithOffset.formatted(date: .long, time: .omitted) <= selectedDate.formatted(date: .long, time: .omitted) && endDateWithOffset.formatted(date: .long, time: .omitted) >= selectedDate.formatted(date: .long, time: .omitted)
        }
        return tracksForDate.isEmpty ? nil : tracksForDate
    }
    
    // Sorted tracks
    private func sortedTracksForDate() -> [Track]? {
        guard let tracks = tracksForDate() else { return nil }
        return tracks.sorted { $0.name < $1.name }
    }
    
    // Get all tracks not match the date
    private func tracksNotForDate() -> [Track]? {
        guard let tracks = tracks() else { return nil }
        let formatter = DateFormatter()
        let tracksNotForDate = tracks.filter { track in
            let hoursInSeconds: TimeInterval = 60 * 60
            let startDateWithOffset = track.startDate.addingTimeInterval(hoursInSeconds * 7)
            let endDateWithOffset = track.endDate.addingTimeInterval(hoursInSeconds * 7)
            return startDateWithOffset.formatted(date: .long, time: .omitted) < selectedDate.formatted(date: .long, time: .omitted) && endDateWithOffset.formatted(date: .long, time: .omitted) < selectedDate.formatted(date: .long, time: .omitted) || startDateWithOffset.formatted(date: .long, time: .omitted) > selectedDate.formatted(date: .long, time: .omitted) && endDateWithOffset.formatted(date: .long, time: .omitted) > selectedDate.formatted(date: .long, time: .omitted)
        }
        return tracksNotForDate.isEmpty ? nil : tracksNotForDate
    }
    
    // Sorted tracks
    private func sortedTracksNotForDate() -> [Track]? {
        guard let tracks = tracksNotForDate() else { return nil }
        return tracks.sorted { $0.name < $1.name }
    }
    
    // All function below is for attendances
    // Get all trackstudents for the track
    private func trackstudentsForTrack(track: Track) -> [TrackStudent]? {
        let trackstudents = data.trackstudents.filter { $0.track_id == track.id }
        return trackstudents.isEmpty ? nil : trackstudents
    }
    
    // Get all attendances match the trackstudents
    private func attendancesForTrack(track: Track) -> [Attendance]? {
        guard let trackstudents = trackstudentsForTrack(track: track) else { return [] }
        let attendances = data.attendances.filter { attendance in
            trackstudents.contains(where: { $0.id == attendance.trackstudent_id })
        }
        return attendances.isEmpty ? nil : attendances
    }
    
    // Get all attendances match the date
    private func attendancesForDate(track: Track) -> [Attendance]? {
        guard let attendancesForTrack = attendancesForTrack(track: track) else { return nil }
        let formatter = DateFormatter()
        let attendances = attendancesForTrack.filter { attendance in
            let hoursInSeconds: TimeInterval = 60 * 60
            let dateWithOffset = attendance.date.addingTimeInterval(hoursInSeconds * 7)
            return dateWithOffset.formatted(date: .long, time: .omitted) == selectedDate.formatted(date: .long, time: .omitted)
        }
        return attendances.isEmpty ? nil : attendances
    }
    
    // Get number of Attendances
    private func totalAttendances(track: Track) -> Int {
        return attendancesForDate(track: track)?.count ?? 0
    }
    
    // Get number of checkIn
    private func numberOfCheckedInAttendances(track: Track) -> Int {
        guard let attendances = attendancesForDate(track: track) else { return 0 }
        return attendances.filter { $0.checkInTime != Date(timeIntervalSince1970: 0) }.count
    }
    
    // Get number of checkOut
    private func numberOfCheckedOutAttendances(track: Track) -> Int {
        guard let attendances = attendancesForDate(track: track) else { return 0 }
        return attendances.filter { $0.checkOutTime != Date(timeIntervalSince1970: 0) }.count
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 35)
                Text("All Tracks")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                    .frame(height: 35)
                    .padding(.leading, 15)
                
                Spacer(minLength: 0)
                
                // Tracks list for the date
                let tracks = sortedTracksForDate()
                let tracksNotForDate = sortedTracksNotForDate()
                
                if tracks == nil && tracksNotForDate == nil {
                    Color.white
                        .frame(width: 396, height: 212)
                        .opacity(0)
                        .padding([.leading, .trailing], 35)
                } else if tracks == nil {
                } else {
                ForEach(tracks!, id: \.id) { track in
                    TrackView(data: data, track: track)
                    .onTapGesture {
                        self.selectedTrack = track
                    }
                    .sheet(item: $selectedTrack) { selectedTrack in
                        TrackDetailView(data: data, track: selectedTrack)
                    }
                }
                .padding(.bottom, 20)
                .padding(.leading, 15)
                .padding(.trailing, 35)
                }
                
                // List for tracks not for the date
                if tracksNotForDate == nil {
                } else {
                // List for tracks not for the date
                ForEach(tracksNotForDate!, id: \.id) { track in
                    TrackView(data: data, track: track)
                    .onTapGesture {
                        self.selectedTrack = track
                    }
                    .sheet(item: $selectedTrack) { selectedTrack in
                        TrackDetailView(data: data, track: selectedTrack)
                    }
                    .opacity(0.4)
                }
                .padding(.bottom, 20)
                .padding(.leading, 15)
                .padding(.trailing, 35)
                }
                
            }
        }
        .padding(.bottom, 15)
    }
}

struct TrackListView_Previews: PreviewProvider {
    static var previews: some View {
        TrackListView(data: HTTPClient())
    }
}
