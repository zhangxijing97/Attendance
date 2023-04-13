//
//  HTTPMovieClient.swift
//  MoviesApp
//
//  Created by Mohammad Azam on 6/16/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation

class HTTPClient: ObservableObject {
    
    @Published var students: [Student] = [Student]()
    @Published var tracks: [Track] = [Track]()
    @Published var trackstudents: [TrackStudent] = [TrackStudent]()
    @Published var sessions: [Session] = [Session]()
    @Published var attendances: [Attendance] = [Attendance]()
    
    @Published var selectedView: Int = 1 // Property to select the View
    @Published var selectedDate = Date() // Property to select the Date
    
//    192.168.0.219:8080
}
