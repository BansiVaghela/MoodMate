//
//  MoodCardView.swift
//  MoodMate
//
//  Created by Bansi Vaghela on 14/07/25.
//

import SwiftUI

struct MoodCardView: View {
    let moodCard: MoodCard
    @Binding var selectedMood: Mood?
    var onSave: (String?) -> Void
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image(systemName: moodCard.icon)
                    .foregroundColor(.purple)
                    .font(.title3)
                
                Text(moodCard.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            let rows = moodCard.moods.chunked(into: 3)
            
            VStack(spacing: 16) {
                ForEach(rows.indices, id: \.self) { rowIndex in
                    HStack(spacing: 16) {
                        ForEach(rows[rowIndex]) { mood in
                            MiniEmojiCardView(
                                mood: mood,
                                isSelected: selectedMood?.id == mood.id,
                                onTap: {
                                    if selectedMood?.id != mood.id {
                                        selectedMood = mood
                                    }
                                    onSave(selectedMood?.emoji)
                                }
                            )
                        }
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
        )
        .padding(.horizontal, UIScreen.main.bounds.width/20)
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

#Preview {
    ScrollView {
        MoodCardView(
            moodCard: MoodCard(
                icon: "sparkle", title: "How are you feeling today?",
                moods: [Mood(id: 1, emoji: "😀", label: "Happy", bgColor: "red"),Mood(id: 1, emoji: "😐", label: "Neutral", bgColor: "red"),]
            ), selectedMood: .constant(Mood(id: 1, emoji: "😀", label: "Happy", bgColor: "red")), onSave: {_ in }
        )
    }
}
