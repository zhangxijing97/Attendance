//
//  LogoView.swift
//  Attendance
//
//  Created by 张熙景 on 3/18/23.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(red: 0.3294, green: 0.3647, blue: 0.9215))
                .frame(width: 36, height: 36)
        }
        .frame(width: 70, height: 70)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
