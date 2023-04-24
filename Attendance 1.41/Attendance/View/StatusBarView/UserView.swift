//
//  UserView.swift
//  Attendance
//
//  Created by 张熙景 on 3/18/23.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .fill(Color(red: 0.9569, green: 0.9608, blue: 0.9686))
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                HStack(spacing: 0) {
                    Spacer()
                    Text("Admin")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                    Spacer()
                    Circle()
                        .fill(Color(red: 0.8470, green: 0.8470, blue: 0.8470))
                        .frame(width: 32, height: 32)
                    Spacer()
                        .frame(width: 2)
                }
            }
            .frame(width: 108)
            Image(systemName: "chevron.down")
                .foregroundColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                .frame(width: 35)
            Rectangle()
                .fill(Color.white)
                .frame(width: 35)
        }
        .frame(width: 178,height: 36)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
