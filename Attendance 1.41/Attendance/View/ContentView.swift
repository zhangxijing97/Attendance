//
//  ContentView.swift
//  Attendance 1.4
//
//  Created by Xijing Zhang on 3/17/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var data = HTTPClient()

    var body: some View {
        VStack {
            if data.tracks.isEmpty {
                LoadingView()
            } else {
                // Display your views here once the data is loaded
                VStack(spacing: 0) {
                    StatusBarView(data: data)
                    HStack(spacing: 0) {
                        LeftTabView(data: data)
                        MainView(data: data)
                    }
                }
                .statusBar(hidden: true)
                .ignoresSafeArea(.all)
            }
        }
        .onAppear {
            data.readData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
