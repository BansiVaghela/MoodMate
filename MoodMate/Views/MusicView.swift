//
//  MusicView.swift
//  MoodMate
//
//  Created by Bansi Vaghela on 31/08/25.
//
import SwiftUI

struct MusicView: View {
    let music: MusicList
    let currentMood: String?
    @StateObject private var musicManager = MusicManager.shared
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image(systemName: music.icon)
                    .foregroundColor(.purple)
                    .font(.title3)
                
                Text(music.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
            }
            .padding()
            if let mood = currentMood {
                let moodSongs = music.songsList.songs(for: mood)
                // Song List
                ForEach(moodSongs) { song in
                    HStack {
                        Image(systemName: music.musicIcon)
                            .foregroundColor(.purple)
                            .padding(.horizontal, 5)
                        
                        VStack(alignment: .leading) {
                            Text(song.songTitle)
                                .font(.subheadline)
                                .fontWeight(.medium)
                            Text(song.artist)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Button {
                            musicManager.play(songFile: song.fileName)
                        } label: {
                            Image(systemName: (musicManager.currentSong == song.fileName && musicManager.isPlaying)
                                  ? "pause.circle.fill"
                                  : "play.circle.fill")
                            .font(.title2)
                            .foregroundColor(.purple)
                        }
                    }
                    .padding(.vertical, 4)
                }
            } else {
                Text("No mood selected")
                    .foregroundColor(.gray)
            }
            Spacer()
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
    MusicView(music: MusicList(icon: "headphones", title: "Hello", musicIcon: "Hello", songsList: SongsList(positive: [], negative: [], neutral: []), playIcon: "star"), currentMood: "positive")
}
