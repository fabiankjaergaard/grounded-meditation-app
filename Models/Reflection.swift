//
//  Reflection.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import Foundation

/// A user's written reflection for a video or meditation
struct Reflection: Codable, Identifiable {
    var id: UUID
    var videoId: String
    var text: String
    var date: Date

    init(
        id: UUID = UUID(),
        videoId: String,
        text: String,
        date: Date = Date()
    ) {
        self.id = id
        self.videoId = videoId
        self.text = text
        self.date = date
    }
}
