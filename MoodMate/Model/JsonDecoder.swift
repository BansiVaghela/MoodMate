//
//  JsonDecoder.swift
//  MoodMate
//
//  Created by Bansi Vaghela on 13/07/25.
//

import Foundation

class JSONLoader {
    static func loadUIConfig(from filename: String) -> AppUIConfig? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return nil }

        let decoder = JSONDecoder()
        return try? decoder.decode(AppUIConfig.self, from: data)
    }
}
