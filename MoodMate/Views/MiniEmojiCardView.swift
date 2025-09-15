//
//  MiniEmojiCardView.swift
//  MoodMate
//
//  Created by Bansi Vaghela on 14/07/25.
//

import SwiftUI

struct MiniEmojiCardView: View {
    let mood: Mood
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: {
            onTap()
        }) {
            VStack(spacing: 4) {
                Text(mood.emoji)
                    .font(.largeTitle)
                Text(mood.label)
                    .font(.caption)
                    .foregroundColor(isSelected ? .white : .secondary)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? mood.backgroundColor : Color(.systemBackground))
                    .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
            )
            .foregroundColor(isSelected ? .white : .primary)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    MiniEmojiCardView(
        mood: Mood(id: 1, emoji: "😀", label: "Happy", bgColor: "pink"), isSelected: false,
        onTap: {}
    )
    .padding()
    .background(Color.gray.opacity(0.2))
}
