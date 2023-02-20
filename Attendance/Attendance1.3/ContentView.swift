//
//  ContentView.swift
//  Attendance1.3
//
//  Created by 张熙景 on 2/15/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var students = StudentData()
    @ObservedObject var trackData = TrackData()
    
    var body: some View {
        VStack {
            TabView {
                TrackView()
                    .tabItem({
                        Label("Tracks", systemImage: "text.book.closed")
                    })
                
                StudentView()
                    .tabItem({
                        Label("Students", systemImage: "person.2")
                    })
            }
        }
        .onAppear {
            self.students.loadData()
            self.trackData.loadData()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

