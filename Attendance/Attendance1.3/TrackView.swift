//
//  TrackView.swift
//  Attendance1.0
//
//  Created by 张熙景 on 2/2/23.
//

import SwiftUI

struct TrackView: View {
    @StateObject var trackData = TrackData()
    @State private var offset: CGFloat = 0
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                Color(.white)
                    .frame(height: 80)
                VStack(alignment: .leading) {
                    
                    Text("ASU Mesa MIX Center").font(.custom("Athelas", size: 34)).bold()
                        .padding([.leading, .trailing], 40)
                        .padding(.bottom, -2)
                    HStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            ZStack(alignment: .leading) {
                                Color(.white).opacity(0)
                                    .frame(width: 1572)
                                HStack {
                                    ForEach(0..<min(trackData.tracks.count, 3), id: \.self) { index in
                                        let track = trackData.tracks[index]
                                        VStack(alignment: .leading) {
                                            Color(.gray)
                                                .frame(width: 360, height: 0.5)
                                            Spacer(minLength: 32)
                                            Text("Date: June 12 - 16, 2023").font(.custom("Athelas", size: 24)).bold()
                                            Spacer(minLength: 4)
                                            Text("Time: 9:00 AM - 4:00 PM (MST)").font(.custom("Athelas", size: 24)).bold()
                                            NavigationLink {
                                                SectionView(track: $trackData.tracks[index], trackData: trackData)
                                            } label: {
                                                VStack {
                                                    Text("")
                                                        .modifier(TrackList(index: index, track: track, trackData: trackData))
                                                }
                                            }
                                        }
                                    }
                                    .padding(.trailing, 24)
                                    .padding(.bottom, 20)
                                }
                                .padding([.leading, .trailing], 40)
                            }
                        }
                        .background(LinearGradient(gradient: Gradient(colors: [.white, Color(red: 0.945, green: 0.945, blue: 0.945)]), startPoint: .top, endPoint: .bottom))
                    }
                    
                    Text("ASU Tempe").font(.custom("Athelas", size: 34)).bold()
                        .padding([.leading, .trailing], 40)
                        .padding(.top, 32)
                        .padding(.bottom, -2)
                    HStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            ZStack(alignment: .leading) {
                                Color(.white).opacity(0)
                                    .frame(width: 1964)
                                HStack {
                                    ForEach(3..<min(trackData.tracks.count, 7), id: \.self) { index in
                                        let track = trackData.tracks[index]
                                        VStack(alignment: .leading) {
                                            Color(.gray)
                                                .frame(width: 360, height: 0.5)
                                            Spacer(minLength: 32)
                                            Text("Date: June 19 - 23, 2023").font(.custom("Athelas", size: 24)).bold()
                                            Spacer(minLength: 4)
                                            Text("Time: 9:00 AM - 4:00 PM (MST)").font(.custom("Athelas", size: 24)).bold()
                                            NavigationLink {
                                                SectionView(track: $trackData.tracks[index], trackData: trackData)
                                            } label: {
                                                VStack {
                                                    Text("")
                                                        .modifier(TrackList(index: index, track: track, trackData: trackData))
                                                }
                                            }
                                        }
                                    }
                                    .padding(.trailing, 24)
                                    .padding(.bottom, 20)
                                }
                                .padding([.leading, .trailing], 40)
                            }
                        }
                        .background(LinearGradient(gradient: Gradient(colors: [.white, Color(red: 0.945, green: 0.945, blue: 0.945)]), startPoint: .top, endPoint: .bottom))
                    }
                    
                    Text("ASU Tempe").font(.custom("Athelas", size: 34)).bold()
                        .padding([.leading, .trailing], 40)
                        .padding(.top, 32)
                        .padding(.bottom, -2)
                    HStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            ZStack(alignment: .leading) {
                                Color(.white).opacity(0)
                                    .frame(width: 1572)
                                HStack {
                                    ForEach(7..<min(trackData.tracks.count, 10), id: \.self) { index in
                                        let track = trackData.tracks[index]
                                        VStack(alignment: .leading) {
                                            Color(.gray)
                                                .frame(width: 360, height: 0.5)
                                            Spacer(minLength: 32)
                                            Text("Date: June 26 - 30, 2023").font(.custom("Athelas", size: 24)).bold()
                                            Spacer(minLength: 4)
                                            Text("Time: 9:00 AM - 4:00 PM (MST)").font(.custom("Athelas", size: 24)).bold()
                                            NavigationLink {
                                                SectionView(track: $trackData.tracks[index], trackData: trackData)
                                            } label: {
                                                VStack {
                                                    Text("")
                                                        .modifier(TrackList(index: index, track: track, trackData: trackData))
                                                }
                                            }
                                        }
                                    }
                                    .padding(.trailing, 24)
                                    .padding(.bottom, 20)
                                }
                                .padding([.leading, .trailing], 40)
                            }
                        }
//                        .background(LinearGradient(gradient: Gradient(colors: [.white, Color(red: 0.945, green: 0.945, blue: 0.945)]), startPoint: .top, endPoint: .bottom))
                    }
                    
                }
            }
            WelcomeView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TrackView_Previews: PreviewProvider {
    static var previews: some View {
        TrackView()
    }
}
