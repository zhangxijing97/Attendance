//
//  ViewModifier.swift
//  DCSI
//
//  Created by 张熙景 on 2/11/23.
//

import SwiftUI

struct TrackList: ViewModifier {
    var index: Int
    var track: Track
    
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
