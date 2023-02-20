//
//  StudentView.swift
//  Attendance1.0
//
//  Created by 张熙景 on 2/2/23.
//

import SwiftUI

struct StudentView: View {
    @StateObject var students = StudentData()
    @State private var showingAddStudent = false
    @State private var searchText = "" // Search code part I
    
    var body: some View {
        NavigationView {
            List {
                
                ForEach(0 ..< students.students.count, id: \.self) { index in
                    NavigationLink(destination: StudentDetailView(student: $students.students[index], students: students)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(students.students[index].name)
                            }
                        }
                    }
                }
                .onDelete(perform: removeItems)
                
            }
//            .searchable(text: $searchText, prompt: "Search") // Search code part II
            .navigationTitle("Students")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { // Edit button
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) { // Add button
                    Button {
                        showingAddStudent.toggle()
                    } label: {
                        Image(systemName: "plus")                    }
                }
            }
            .sheet(isPresented: $showingAddStudent) {
                AddStudentView(students: students)
            }
            
        }
    }
    
//    var filteredNames: [Student] { // Search code part III
//        if searchText.isEmpty {
//            return students.students
//        } else {
//            return students.students.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
//        }
//    }
    
    func removeItems(at offsets: IndexSet) {
        students.students.remove(atOffsets: offsets)
    }
    
//    private func initializeStudents() {
//        let loadStudents: [Student] = Bundle.main.decode("students.json")
//        students.students.append(contentsOf: loadStudents)
//    }
    
}

struct StudentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentView()
    }
}
