//
//  HomeView.swift
//  MoodMate
//
//  Created by Bansi Vaghela on 13/07/25.
//

import SwiftUI
import CoreML

struct HomeView: View {
    @State private var cards: CardData? = nil
    @State private var headerData: HeaderData? = nil
    @State private var animate = false
    @State private var selectedMood: Mood? = nil
    @State private var predictedMood: String = "neutral"
    @State private var quotesByMood: QuotesByMood? = nil
    @State private var selectedQuote: String? = nil
    
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ZStack {
            (selectedMood?.backgroundColor ?? Color.purple.opacity(0.9))
                .ignoresSafeArea()
                .onTapGesture { isTextFieldFocused = false }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Header
                    if let header = headerData {
                        HeaderView(headerData: header)
                            .opacity(animate ? 1 : 0)
                            .offset(y: animate ? 0 : 40)
                            .animation(.easeOut(duration: 0.6), value: animate)
                    }
                    
                    // Mood Selection
                    if let moodCard = cards?.moodCards {
                        MoodCardView(moodCard: moodCard, selectedMood: $selectedMood) { selectedEmoji in
                            if let mood = selectedEmoji {
                                updateMoodAndQuote(from: mood)
                            } else {
                                resetMood()
                            }
                        }
                    }
                    
                    // Write about your mood section
                    if let thoughts = cards?.thoughtCard {
                        WriteYourFeelingsCardView(
                            thoughts: thoughts,
                            isTextFieldFocused: $isTextFieldFocused
                        ) { savedText in
                            updateMoodAndQuote(from: savedText)
                        }
                    }
                    
                    // Quote Section
                    if let quotes = cards?.quoteCard {
                        QuoteView(quotes: quotes, selectedQuote: selectedQuote)
                    }
                    
                    // Music Section
                    if let music = cards?.musicCard {
                        MusicView(music: music, currentMood: predictedMood.lowercased())
                    }
                }
            }
        }
        .onTapGesture { isTextFieldFocused = false }
        .onAppear { loadConfig() }
    }
}

// MARK: - Helpers
extension HomeView {
    
    private func loadConfig() {
        if let config = JSONLoader.loadUIConfig(from: "AppUIConfig") {
            self.headerData = config.headers
            self.cards = config.cards
            self.quotesByMood = config.quotesList
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.animate = true
            }
        }
    }
    
    // Update mood based on text or emoji
    private func updateMoodAndQuote(from input: String) {
        let moodLabel = predictMood(from: input).lowercased()
        self.predictedMood = moodLabel
        
        if let list = quotesByMood?[moodLabel], !list.isEmpty {
            self.selectedQuote = list.randomElement()
        } else {
            self.selectedQuote = "Life is full of colors — paint your day with positivity."
        }
    }
    
    // Reset state when user clears mood
    private func resetMood() {
        self.predictedMood = "neutral"
        self.selectedQuote = "Life is full of colors — paint your day with positivity."
    }
    
    // CoreML Mood Prediction
    func predictMood(from text: String) -> String {
        do {
            let model = try MoodClassifier(configuration: MLModelConfiguration())
            let prediction = try model.prediction(text: text)
            return prediction.label
        } catch {
            print("Error predicting mood: \(error)")
            return "neutral"
        }
    }
}

extension Color {
    init?(hex: String) {
        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hex.hasPrefix("#") { hex.removeFirst() }
        
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        
        self.init(red: r, green: g, blue: b)
    }
}

#Preview {
    HomeView()
}
