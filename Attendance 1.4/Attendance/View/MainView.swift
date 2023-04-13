//
//  MainView.swift
//  Attendance
//
//  Created by 张熙景 on 3/18/23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var data: HTTPClient
    @State private var isPresented: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 0.9569, green: 0.9608, blue: 0.9686))
                .cornerRadius(20, corners: [.topLeft])
            if data.selectedView == 1 {
                    DashBoardView(data: data)
            } else if data.selectedView == 2 {
                StudentView(data: data)
            } else if data.selectedView == 3 {
//                AddStudentView()
            }
        }
        .sheet(isPresented: $isPresented, onDismiss: {
//            await data.readStudent()
        }, content: {
            AddStudentView()
        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(data: HTTPClient())
    }
}
