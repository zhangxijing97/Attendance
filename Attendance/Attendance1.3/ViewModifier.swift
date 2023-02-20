//
//  ViewModifier.swift
//  DCSI
//
//  Created by 张熙景 on 2/11/23.
//

import SwiftUI

struct CheckInCheckOutButtonModifier: ViewModifier {
    var index: Int
    @Binding var track: Track
    var checkInTime: String?
    var propertyName: String
    var buttonText: String
    
    func body(content: Content) -> some View {
        if let sectionACourse1CheckInTime = checkInTime { // // Check In Button For Section A
            Text(sectionACourse1CheckInTime)
                .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
        } else {
            Button(action: {}) {
                Text(buttonText)
                    .frame(minWidth: 95, idealWidth: 190, maxWidth: 200, alignment: .leading)
            }
            .onTapGesture {
                let studentIndex = self.track.students.firstIndex(where: { $0.id == self.track.students[index].id })
                if let studentIndex = studentIndex {
                    var updatedStudent = self.track.students[index]
        
                    let dateFormatter = DateFormatter() // Change the Date format
                    dateFormatter.dateFormat = "MM/dd HH:mm"
                    let formattedDate = dateFormatter.string(from: Date())

                    switch propertyName {
                    case "sectionACourse1CheckInTime":
                        updatedStudent.sectionACourse1CheckInTime = formattedDate
                    case "sectionACourse1CheckOutTime":
                        updatedStudent.sectionACourse1CheckOutTime = formattedDate
                    case "sectionBCourse1CheckInTime":
                        updatedStudent.sectionBCourse1CheckInTime = formattedDate
                    case "sectionBCourse1CheckOutTime":
                        updatedStudent.sectionBCourse1CheckOutTime = formattedDate

                    case "sectionACourse2CheckInTime":
                        updatedStudent.sectionACourse2CheckInTime = formattedDate
                    case "sectionACourse2CheckOutTime":
                        updatedStudent.sectionACourse2CheckOutTime = formattedDate
                    case "sectionBCourse2CheckInTime":
                        updatedStudent.sectionBCourse2CheckInTime = formattedDate
                    case "sectionBCourse2CheckOutTime":
                        updatedStudent.sectionBCourse2CheckOutTime = formattedDate

                    case "sectionACourse3CheckInTime":
                        updatedStudent.sectionACourse3CheckInTime = formattedDate
                    case "sectionACourse3CheckOutTime":
                        updatedStudent.sectionACourse3CheckOutTime = formattedDate
                    case "sectionBCourse3CheckInTime":
                        updatedStudent.sectionBCourse3CheckInTime = formattedDate
                    case "sectionBCourse3CheckOutTime":
                        updatedStudent.sectionBCourse3CheckOutTime = formattedDate

                    case "sectionACourse4CheckInTime":
                        updatedStudent.sectionACourse4CheckInTime = formattedDate
                    case "sectionACourse4CheckOutTime":
                        updatedStudent.sectionACourse4CheckOutTime = formattedDate
                    case "sectionBCourse4CheckInTime":
                        updatedStudent.sectionBCourse4CheckInTime = formattedDate
                    case "sectionBCourse4CheckOutTime":
                        updatedStudent.sectionBCourse4CheckOutTime = formattedDate

                    case "sectionACourse5CheckInTime":
                        updatedStudent.sectionACourse5CheckInTime = formattedDate
                    case "sectionACourse5CheckOutTime":
                        updatedStudent.sectionACourse5CheckOutTime = formattedDate
                    case "sectionBCourse5CheckInTime":
                        updatedStudent.sectionBCourse5CheckInTime = formattedDate
                    case "sectionBCourse5CheckOutTime":
                        updatedStudent.sectionBCourse5CheckOutTime = formattedDate
                    default:
                        break
                    }
                    self.track.students[studentIndex] = updatedStudent
                }
            }
        }
    }
}

struct TrackList: ViewModifier {
    var index: Int
    var track: Track
    var trackData: TrackData
    
    func body(content: Content) -> some View {
        HStack {
            ZStack(alignment: .leading) {
                Color(red: track.color.red, green: track.color.green, blue: track.color.blue)
                    .frame(width: 360)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: Color(red: track.color.red, green: track.color.green, blue: track.color.blue).opacity(0.4), radius: 10, x: 0, y: 10)
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "list.dash").foregroundColor(.white).font(.system(size: 23)).bold()
                        Text(track.name).foregroundColor(.white).font(.system(size: 23)).bold()
                        Spacer()
                        HStack {
                            ZStack {
                                Circle().fill(.white).opacity(0.4).frame(width: 50, height: 50)
                                Circle().fill(Color(red: track.SectionAColor2.red, green: track.SectionAColor2.green, blue: track.SectionAColor2.blue)).frame(width: 40, height: 40)
                                Image(systemName: track.SectionAIcon).bold().foregroundColor(Color(red: track.SectionAColor1.red, green: track.SectionAColor1.green, blue: track.SectionAColor1.blue))
                            }
                            ZStack {
                                Circle().fill(.white).opacity(0.4).frame(width: 50, height: 50)
                                Circle().fill(Color(red: track.SectionBColor2.red, green: track.SectionBColor2.green, blue: track.SectionBColor2.blue)).frame(width: 40, height: 40)
                                Image(systemName: track.SectionBIcon).bold().foregroundColor(Color(red: track.SectionBColor1.red, green: track.SectionBColor1.green, blue: track.SectionBColor1.blue))
                            }
                        }
                    }
                    .frame(width: 328)
                    Spacer(minLength: 16)
                    HStack(spacing: 0) {
                        Text("< \(track.sections[0])").font(.system(size: 17, weight: .medium)).foregroundColor(.white).lineLimit(1).truncationMode(.tail)
                        Text(" >").font(.system(size: 17, weight: .medium)).foregroundColor(.white)
                    }
                    Spacer(minLength: 8)
                    HStack(spacing: 0) {
                        Text("< \(track.sections[1])").font(.system(size: 17, weight: .medium)).foregroundColor(.white).lineLimit(1).truncationMode(.tail)
                        Text(" >").font(.system(size: 17, weight: .medium)).foregroundColor(.white)
                    }
                    Spacer(minLength: 16)
                    HStack(spacing: 3) {
                        Image(systemName: "location").font(.system(size: 14, weight: .semibold)).foregroundColor(.white).opacity(0.6)
                        Text(track.location).font(.system(size: 14, weight: .medium)).foregroundColor(.white).opacity(0.6)
                    }
                    Spacer(minLength: 4)
                    HStack(spacing: 3) {
                        Image(systemName: "clock").font(.system(size: 14, weight: .semibold)).foregroundColor(.white).opacity(0.6)
                        Text(track.date).font(.system(size: 14, weight: .medium)).foregroundColor(.white).opacity(0.6)
                    }
                    Spacer(minLength: 8)
                }
                .padding()
            }
        }
        .padding(.bottom)
    }
}
