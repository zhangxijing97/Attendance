//
//  StatusBarView.swift
//  Attendance
//
//  Created by 张熙景 on 3/17/23.
//

import SwiftUI

struct StatusBarView: View {
    @ObservedObject var data: HTTPClient
    
    var body: some View {
        HStack(spacing: 0) {
            LogoView()
            DateView(data: data)
            Spacer()
            UserView()
        }
        .frame(height: 70)
    }
}

struct StatusBarView_Previews: PreviewProvider {
    static var previews: some View {
        StatusBarView(data: HTTPClient())
    }
}
