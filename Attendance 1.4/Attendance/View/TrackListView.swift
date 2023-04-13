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
    
    var selectedDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        return dateFormatter.string(from: data.selectedDate)
    }
    
    // Return track that one of track.days == selectedDateString
//    var tracks: [Track] {
//        data.tracks.filter { track in
//            track.days.contains(selectedDateString)
//        }
//    }

    // Return track that one of track.days == selectedDateString
    var tracks: [Track] {
        data.tracks
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
                    .padding(.leading, 35)
                
                if tracks.isEmpty {
                    // When tracks.isEmpty, show something in this place
                    Color.white
                        .frame(width: 396, height: 212)
                        .opacity(0)
                        .padding([.leading, .trailing], 35)
                } else {
                    
                ForEach(tracks, id: \.id) { track in
                    ZStack {
                        // Shadow
                        Color.white
                            .frame(width: 396, height: 212)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black, radius: 2, x: 0, y: 2)
                            .opacity(0.2)
                        // Background of TrackView
                        Color.white
                            .frame(width: 396, height: 212)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .onTapGesture {
                                self.isTrackDetailViewPresented = true
                            }
                        TrackView(data: data, track: track)
                    }
                    .sheet(isPresented: $isTrackDetailViewPresented, content: {
//                        TrackDetailView(data: data, track: $selectedTrack)
                    })
                }
                .padding(.bottom, 15)
                .padding([.leading, .trailing], 35)
                }
                
            }
        }
        .padding(.bottom, 20)
    }
}

struct TrackListView_Previews: PreviewProvider {
    static var previews: some View {
        TrackListView(data: HTTPClient())
    }
}
