//
//  Tab.swift
//  Attendance
//
//  Created by 张熙景 on 3/18/23.
//

import SwiftUI

struct Tab: View {
    @ObservedObject var data: HTTPClient
    
    var body: some View {
        VStack {
            Icon(imageName: "house.fill", isSelected: data.selectedView == 1) {
                data.selectedView = 1
            }
            .frame(height:70)
            Icon(imageName: "person.fill", isSelected: data.selectedView == 2) {
                data.selectedView = 2
            }
            .frame(height:70)
            Icon(imageName: "person.fill.badge.plus", isSelected: data.selectedView == 3) {
                data.selectedView = 3
            }
            .frame(height:70)
        }
    }
}

struct Icon: View {
    let imageName: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Image(systemName: imageName)
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .foregroundColor(isSelected ? Color(red: 0.3294, green: 0.3647, blue: 0.9215) : Color(red: 0.0000, green: 0.1176, blue: 0.2824))
            .onTapGesture(perform: action)
            .scaleEffect(isSelected ? 1.1 : 1)
    }
}

struct Tab_Previews: PreviewProvider {
    static var previews: some View {
        Tab(data: HTTPClient())
    }
}
