//
//  ContentView.swift
//  Attendance1.3
//
//  Created by 张熙景 on 2/15/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var data = AppData()
    
    var body: some View {
        VStack {
            TabView {
                TrackView(data: data)
                    .tabItem({
                        Label("Tracks", systemImage: "text.book.closed")
                    })
                
                StudentView(data: data)
                    .tabItem({
                        Label("Students", systemImage: "person.2")
                    })
            }
        }
        .onAppear {
            self.data.loadTracks()
            self.data.loadStudents()
            self.data.loadTracks()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

