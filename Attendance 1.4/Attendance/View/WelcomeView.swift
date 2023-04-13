//
//  WelcomeView.swift
//  Attendance 1.32
//
//  Created by Xijing Zhang on 3/17/23.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Welcome to Attendance App for Digital Culture Summer Institute")
                .font(.largeTitle)
            Text(" ")
            Text("The School of Arts, Media and Engineering annually hosts a summer program for students ages 12 to 18, featuring 5-day, project-focused workshops.")
                .foregroundColor(.secondary)
            Text(" ")
            Text("Students work directly with faculty and graduate students who are experts in their field. Open to students of all levels of experience, we offer a variety of interdisciplinary classes infused with ideas and practices from the arts, music, digital media, computer science, technology and engineering. Future makers, artists, designers, engineers, and entrepreneurs will learn skills valuable for the technology-infused, fast-paced 21st century. We are excited to work with you this summer - come spark your creativity integrating arts, science and engineering!")
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 100)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
