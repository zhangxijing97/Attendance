//
//  StudentView.swift
//  Attendance1.0
//
//  Created by 张熙景 on 2/2/23.
//

import SwiftUI

struct StudentView: View {
    @ObservedObject var data: AppData
    @State private var showingAddStudent = false
    @State private var searchText = "" // Search code part I
    
    var body: some View {
        NavigationView {
            List {
                
                ForEach(0 ..< data.students.count, id: \.self) { index in
                    NavigationLink(destination: StudentDetailView(student: $data.students[index], data: data)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(data.students[index].name)
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
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddStudent) {
                AddStudentView(data: data)
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
        data.students.remove(atOffsets: offsets)
    }
}

struct StudentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentView(data: AppData())
    }
}
