//
//  StudentView.swift
//  Attendance 1.32
//
//  Created by Xijing Zhang on 3/17/23.
//

import SwiftUI

struct StudentView: View {
    var student: Student
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white
                    .frame(height: 60)
                
                HStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ZStack {
                            Circle()
                                .fill(Color(red: 0.8470, green: 0.8470, blue: 0.8470))
                                .frame(width: 35, height: 35)
                            if student.gender == "Male" {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .foregroundColor(.blue)
                                    .opacity(0.8)
                            } else if student.gender == "Female" {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .foregroundColor(.pink)
                                    .opacity(0.8)
                            } else {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .opacity(0.5)
                            }
                        }
                        Spacer()
                            .frame(width: 15)
                        Text(student.name)
                        Spacer()
                    }
                    .frame(width: (geometry.size.width) / 4, alignment: .leading)
                    Text(student.referenceNumber)
                        .frame(width: (geometry.size.width) / 4, alignment: .leading)
                    Text(student.emailAddress)
                        .frame(width: (geometry.size.width) / 4, alignment: .leading)
                    Text(student.phoneNumber)
                        .frame(width: (geometry.size.width) / 4, alignment: .leading)
                }
                .bold()
                .font(.system(size: 14, design: .rounded))
                .foregroundColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                
            }
        }
    }
}


//struct StudentView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudentView(student: Student)
//    }
//}
