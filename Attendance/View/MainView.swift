//
//  MainView.swift
//  Attendance
//
//  Created by 张熙景 on 3/18/23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var data: HTTPClient
    @State private var isPresentedAddStudent: Bool = false
    @State private var isPresentedAddTrack: Bool = false
    @State private var previousView: Int = 0
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 0.9569, green: 0.9608, blue: 0.9686))
                .cornerRadius(20, corners: [.topLeft])
            if data.selectedView == 1 {
                    DashBoardView(data: data)
            } else if data.selectedView == 2 {
                StudentListView(data: data)
            }
        }
        .onReceive(data.$selectedView) { newValue in
            if newValue == 1 {
                self.previousView = 1
            } else if newValue == 2 {
                self.previousView = 2
            } else if newValue == 3 {
                self.isPresentedAddStudent = true
                self.data.selectedView = previousView
            } else if newValue == 4 {
                self.isPresentedAddTrack = true
                self.data.selectedView = previousView
            }
        }
        .sheet(isPresented: $isPresentedAddStudent, onDismiss: {
            self.data.readData()
        }, content: {
            AddStudentView()
        })
        .sheet(isPresented: $isPresentedAddTrack, onDismiss: {
            self.data.readData()
        }, content: {
            AddTrackView()
        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(data: HTTPClient())
    }
}
