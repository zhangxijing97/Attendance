//
//  LoadingView.swift
//  Attendance
//
//  Created by 张熙景 on 4/2/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 0.9569, green: 0.9608, blue: 0.9686))
            VStack {
                Text("Loading...")
                ProgressView()
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
