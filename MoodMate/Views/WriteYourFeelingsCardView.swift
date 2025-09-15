//
//  WriteYourFeelingsCardView.swift
//  MoodMate
//
//  Created by Bansi Vaghela on 30/08/25.
//
//

import SwiftUI
import CoreML

struct WriteYourFeelingsCardView: View {
    @State private var text: String = ""
    let thoughts: ThoughtCard
    @FocusState.Binding var isTextFieldFocused: Bool
    var onSave: (String) -> Void
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image(systemName: thoughts.icon)
                    .foregroundColor(.purple)
                    .font(.title3)
                
                Text(thoughts.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
            }

            TextField(thoughts.placeholderString, text: $text, axis: .vertical)
                .lineLimit(5, reservesSpace: true)
                .padding()
                .focused($isTextFieldFocused)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(.secondaryLabel), lineWidth: 1)
                )
                .padding(.bottom)

            HStack(spacing: 10) {
                Text("\(text.count) \(thoughts.charCountText)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Button {
                    onSave(text)
                    isTextFieldFocused = false
                    text = ""   // clear input
                } label: {
                    Text(thoughts.saveButtonText)
                        .foregroundStyle(.white)
                }
                .disabled(text.isEmpty)
                .padding()
                .background(text.isEmpty ? Color.purple.opacity(0.5) : Color.purple)
                .cornerRadius(10)
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

#Preview {
    @FocusState var isFocused: Bool
    WriteYourFeelingsCardView(thoughts: ThoughtCard(icon: "book.pages.fill", title: "Hello", placeholderString: "Hello", charCountText: "Hello", saveButtonText: "Hello"), isTextFieldFocused: $isFocused, onSave: {_ in })
}
