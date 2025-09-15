//
//  QuoteView.swift
//  MoodMate
//
//  Created by Bansi Vaghela on 31/08/25.
//

import Foundation
import SwiftUI

struct QuoteView: View {
    let quotes: Quotes
    var selectedQuote: String?
    
    var body: some View {
        
        VStack {
            HStack(spacing: 10) {
                Image(systemName: quotes.icon)
                    .foregroundColor(.purple)
                    .font(.title3)
                
                if let text = selectedQuote {
                    Text(text)
                        .font(.headline)
                        .foregroundColor(.primary)
                } else {
                    Text("Every moment is a fresh beginning. 🌱")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                }
                Spacer()
            }
            .padding()
            
            HStack {
                Text(quotes.subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.leading, 35)
                
                Spacer()
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
    QuoteView(quotes: Quotes(icon: "quote.closing", title: "Hello", subtitle: "Hello"))
}
