//
//  HeaderModel.swift
//  MoodMate
//
//  Created by Bansi Vaghela on 13/07/25.
//

import Foundation
import SwiftUICore

struct AppUIConfig: Codable {
    let headers: HeaderData
    let cards: CardData
    let quotesList: QuotesByMood
}

struct HeaderData: Codable {
    let title: String
    let subtitle: String
    let titleColor: String?
    let subtitleColor: String?
}

struct CardData: Codable {
    let moodCards: MoodCard
    let thoughtCard: ThoughtCard
    let quoteCard: Quotes
    let musicCard: MusicList
}

struct MoodCard: Codable {
    let icon: String
    let title: String
    let moods: [Mood]
}

struct Mood: Codable, Identifiable {
    let id: Int
    let emoji: String
    let label: String
    let bgColor: String
    
    var backgroundColor: Color {
        Color(hex: bgColor) ?? .gray
    }
}

struct ThoughtCard: Codable {
    let icon: String
    let title: String
    let placeholderString: String
    let charCountText: String
    let saveButtonText: String
}

struct Quotes: Codable {
    let icon: String
    let title: String
    let subtitle: String
}

struct MusicList: Codable {
    let icon: String
    let title: String
    let musicIcon: String
    let songsList: SongsList
    let playIcon: String
}

struct Song: Codable, Identifiable {
    let id: Int
    let songTitle: String
    let artist: String
    let fileName: String
}

struct SongsList: Codable {
    let positive: [Song]
    let negative: [Song]
    let neutral: [Song]
    
    // Helper to fetch based on mood string
    func songs(for mood: String) -> [Song] {
        switch mood.lowercased() {
        case "positive": return positive
        case "negative": return negative
        case "neutral":  return neutral
        default: return []
        }
    }
}

struct QuotesByMood: Codable {
    let positive: [String]
    let negative: [String]
    let neutral: [String]
    
    subscript(_ mood: String) -> [String]? {
        switch mood.lowercased() {
        case "positive": return positive
        case "negative": return negative
        case "neutral":  return neutral
        default: return nil
        }
    }
}
