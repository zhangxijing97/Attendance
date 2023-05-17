//
//  LeftTabView.swift
//  Attendance
//
//  Created by 张熙景 on 3/17/23.
//

import SwiftUI

struct LeftTabView: View {
//    @ObservedObject var data: AppData
    @ObservedObject var data: HTTPClient
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 35)
            Tab(data: data)
            Spacer()
            TimeView()
            Spacer()
                .frame(height: 70)
        }
        .frame(width: 70)
    }
}

struct LeftTabView_Previews: PreviewProvider {
    static var previews: some View {
        LeftTabView(data: HTTPClient())
    }
}
