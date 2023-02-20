//
//  Bundle-Decodable.swift
//  Attendance1.0
//
//  Created by 张熙景 on 2/2/23.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else { // Set the url
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else { // Load the file
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else { // Decode the Data
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
