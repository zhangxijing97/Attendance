//
//  StudentListView.swift
//  Attendance
//
//  Created by 张熙景 on 4/23/23.
//

import SwiftUI

struct StudentListView: View {
    @ObservedObject var data: HTTPClient
    @State private var selectedStudent: Student?
    
    private func totalStudents() -> Int {
        return data.students.count
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                ScrollView() {
                    
                    if selectedStudent == nil {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Spacer()
                                    .frame(width: 35)
                                Text("Students List")
                                    .font(.system(size: 12, weight: .bold, design: .rounded))
                                    .foregroundColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                                    .frame(height: 35)
                                Spacer()
                            }
                        }
                    } else {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Spacer()
                                    .frame(width: 35)
                                Text("Students List / Profile Details")
                                    .font(.system(size: 12, weight: .bold, design: .rounded))
                                    .foregroundColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                                    .frame(height: 35)
                                Spacer()
                            }
                        }
                    }
                    Spacer(minLength: 0)
                    
                    ZStack {
                        Color.white
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black, radius: 2, x: 0, y: 2)
                            .opacity(0.2)
                        Color.white
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 0) {
                                Text("Student Name")
                                    .frame(width: (geometry.size.width - 140) / 4, alignment: .leading)
                                Text("Reference Number")
                                    .frame(width: (geometry.size.width - 140) / 4, alignment: .leading)
                                Text("Email Address")
                                    .frame(width: (geometry.size.width - 140) / 4, alignment: .leading)
                                Text("Phone Number")
                                    .frame(width: (geometry.size.width - 140) / 4, alignment: .leading)
                            }
                            .font(.system(size: 14, design: .rounded))
                            .foregroundColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                            .frame(height: 60)
                            
                            // Show students list
                            ForEach(data.students, id: \.id) { student in
                                StudentView(student: student)
                                .onTapGesture {
                                    self.selectedStudent = student
                                }
                                .sheet(item: $selectedStudent) { selectedStudent in
                                    StudentDetailView(student: selectedStudent)
                                }
                                .frame(height: 60)
                                Rectangle()
                                    .fill(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                                    .opacity(0.2)
                                    .frame(height: 1)
                            }
                            
                            // Show how many students
                            Text("\(totalStudents()) Students")
                            .font(.system(size: 14, design: .rounded))
                            .foregroundColor(Color(red: 0.0000, green: 0.1176, blue: 0.2824))
                            .frame(height: 60)
                        }
                        .padding([.leading, .trailing], 35)
                    }
                    .padding(.bottom, 35)
                    .padding([.leading, .trailing], 35)
                }
            }
            .onAppear {
                self.data.readData()
            }
        }
    }
}

struct StudentListView_Previews: PreviewProvider {
    static var previews: some View {
        StudentListView(data: HTTPClient())
    }
}
