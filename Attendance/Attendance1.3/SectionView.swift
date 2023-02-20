//
//  SectionView.swift
//  Attendance1.0
//
//  Created by 张熙景 on 2/2/23.
//

import SwiftUI

struct SectionView: View {
    @Binding var track: Track
    @ObservedObject var students = StudentData()
    @ObservedObject var trackData = TrackData()
    @State private var showingShowStudentView = false // Show
    
    @State var selectedDate = Date()
    let dateFormatter = DateFormatter()
    let calendar = Calendar.current
    let today = Date()
    var startOfWeek = Calendar.current.date(from: DateComponents(year: 2023, month: 2, day: 13))!
    var endOfWeek = Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 30))!
    
    var selectedDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        return dateFormatter.string(from: selectedDate)
    }
    
    var body: some View {
            List {
                Text(track.location)
                Text("Date: \(track.date)")
                ForEach(0..<track.sections.count, id: \.self) { index in
                    VStack {
                        HStack {
                            Text("Section \(String(Character(UnicodeScalar(index + 65)!)).uppercased()) :")
                            Text(track.sections[index])
                        }
                    }
                }
                
                HStack {
                    Image(systemName: "calendar")
                    DatePicker("Select Date", selection: $selectedDate, in: startOfWeek...endOfWeek, displayedComponents: .date)
                }
                
//                Text("Selected Date: \(selectedDate)")
                
                HStack {
                    Text("All Students").bold()
                        .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                    Text("Section A").bold()
                        .frame(minWidth: 190, idealWidth: 380, maxWidth: 400, alignment: .leading)
                    Text("Section B").bold()
                        .frame(minWidth: 190, idealWidth: 380, maxWidth: 400, alignment: .leading)
                    Button {
                        showingShowStudentView.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "slider.horizontal.3")
                            Text("Edit")
                        }
                    }
                    .frame(alignment: .trailing)
                }
                
                switch selectedDateString {
                    case track.days[0]:
                    ForEach(0..<track.students.count, id: \.self) { index in
                        HStack {
                            Text(track.students[index].name) // Show track.students[index].name
                                .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                            Text("")
                                .modifier(CheckInCheckOutButtonModifier(index: index, track: $track, checkInTime: track.students[index].sectionACourse1CheckInTime, propertyName: "sectionACourse1CheckInTime", buttonText: "Check In"))
                            Text("")
                                .modifier(CheckInCheckOutButtonModifier(index: index, track: $track, checkInTime: track.students[index].sectionACourse1CheckOutTime, propertyName: "sectionACourse1CheckOutTime", buttonText: "Check Out"))
                            Text("")
                                .modifier(CheckInCheckOutButtonModifier(index: index, track: $track, checkInTime: track.students[index].sectionBCourse1CheckInTime, propertyName: "sectionBCourse1CheckInTime", buttonText: "Check In"))
                            Text("")
                                .modifier(CheckInCheckOutButtonModifier(index: index, track: $track, checkInTime: track.students[index].sectionBCourse1CheckOutTime, propertyName: "sectionBCourse1CheckOutTime", buttonText: "Check Out"))
                        }
                    }
                    case track.days[1]:
                    ForEach(0..<track.students.count, id: \.self) { index in
                        HStack {
                            Text(track.students[index].name) // Show track.students[index].name
                                .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                            Text("")
                                .modifier(CheckInCheckOutButtonModifier(index: index, track: $track, checkInTime: track.students[index].sectionACourse2CheckInTime, propertyName: "sectionACourse2CheckInTime", buttonText: "Check In"))
                            Text("")
                                .modifier(CheckInCheckOutButtonModifier(index: index, track: $track, checkInTime: track.students[index].sectionACourse2CheckOutTime, propertyName: "sectionACourse2CheckOutTime", buttonText: "Check Out"))
                            Text("")
                                .modifier(CheckInCheckOutButtonModifier(index: index, track: $track, checkInTime: track.students[index].sectionBCourse2CheckInTime, propertyName: "sectionBCourse2CheckInTime", buttonText: "Check In"))
                            Text("")
                                .modifier(CheckInCheckOutButtonModifier(index: index, track: $track, checkInTime: track.students[index].sectionBCourse2CheckOutTime, propertyName: "sectionBCourse2CheckOutTime", buttonText: "Check Out"))
                        }
                    }
                    case track.days[2]:
                    ForEach(0..<track.students.count, id: \.self) { index in
                        HStack {
                            Text(track.students[index].name) // Show track.students[index].name
                                .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                            Text("")
                                .modifier(CheckInCheckOutButtonModifier(index: index, track: $track, checkInTime: track.students[index].sectionACourse3CheckInTime, propertyName: "sectionACourse3CheckInTime", buttonText: "Check In"))
                            Text("")
                                .modifier(CheckInCheckOutButtonModifier(index: index, track: $track, checkInTime: track.students[index].sectionACourse3CheckOutTime, propertyName: "sectionACourse3CheckOutTime", buttonText: "Check Out"))
                            Text("")
                                .modifier(CheckInCheckOutButtonModifier(index: index, track: $track, checkInTime: track.students[index].sectionBCourse3CheckInTime, propertyName: "sectionBCourse3CheckInTime", buttonText: "Check In"))
                            Text("")
                                .modifier(CheckInCheckOutButtonModifier(index: index, track: $track, checkInTime: track.students[index].sectionBCourse3CheckOutTime, propertyName: "sectionBCourse3CheckOutTime", buttonText: "Check Out"))
                        }
                    }
                    case track.days[3]:
                    ForEach(0..<track.students.count, id: \.self) { index in
                        HStack {
                            Text(track.students[index].name) // Show track.students[index].name
                                .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                            Text("")
                                .modifier(CheckInCheckOutButtonModifier(index: index, track: $track, checkInTime: track.students[index].sectionACourse4CheckInTime, propertyName: "sectionACourse4CheckInTime", buttonText: "Check In"))
                            Text("")
                                .modifier(CheckInCheckOutButtonModifier(index: index, track: $track, checkInTime: track.students[index].sectionACourse4CheckOutTime, propertyName: "sectionACourse4CheckOutTime", buttonText: "Check Out"))
                            Text("")
                                .modifier(CheckInCheckOutButtonModifier(index: index, track: $track, checkInTime: track.students[index].sectionBCourse4CheckInTime, propertyName: "sectionBCourse4CheckInTime", buttonText: "Check In"))
                            Text("")
                                .modifier(CheckInCheckOutButtonModifier(index: index, track: $track, checkInTime: track.students[index].sectionBCourse4CheckOutTime, propertyName: "sectionBCourse4CheckOutTime", buttonText: "Check Out"))
                        }
                    }
                    case track.days[4]:
                    ForEach(0..<track.students.count, id: \.self) { index in
                        HStack {
                            Text(track.students[index].name) // Show track.students[index].name
                                .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
                            Text("")
                                .modifier(CheckInCheckOutButtonModifier(index: index, track: $track, checkInTime: track.students[index].sectionACourse5CheckInTime, propertyName: "sectionACourse5CheckInTime", buttonText: "Check In"))
                            Text("")
                                .modifier(CheckInCheckOutButtonModifier(index: index, track: $track, checkInTime: track.students[index].sectionACourse5CheckOutTime, propertyName: "sectionACourse5CheckOutTime", buttonText: "Check Out"))
                            Text("")
                                .modifier(CheckInCheckOutButtonModifier(index: index, track: $track, checkInTime: track.students[index].sectionBCourse5CheckInTime, propertyName: "sectionBCourse5CheckInTime", buttonText: "Check In"))
                            Text("")
                                .modifier(CheckInCheckOutButtonModifier(index: index, track: $track, checkInTime: track.students[index].sectionBCourse5CheckOutTime, propertyName: "sectionBCourse5CheckOutTime", buttonText: "Check Out"))
                        }
                    }
                    default:
                    Text("Note: The Track doesn't have courses today")
                }
            }
        .sheet(isPresented: $showingShowStudentView) {
            ShowStudentView(track: track, students: students, trackData: trackData, dismiss: $showingShowStudentView)
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        let track = Track.example
        return SectionView(track: .constant(track), trackData: TrackData())
    }
}
