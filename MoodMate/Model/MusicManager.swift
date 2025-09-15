//
//  MusicManager.swift
//  MoodMate
//
//  Created by Bansi Vaghela on 14/09/25.
//

import AVFoundation

class MusicManager: ObservableObject {
    static let shared = MusicManager()
    private var player: AVAudioPlayer?
    @Published var isPlaying: Bool = false
    @Published var currentSong: String? = nil

    func play(songFile: String) {
        if currentSong == songFile, let player = player {
            if player.isPlaying {
                player.pause()
                isPlaying = false
            } else {
                player.play()
                isPlaying = true
            }
            return
        }

        guard let url = Bundle.main.url(forResource: songFile, withExtension: nil) else {
            print("Song not found: \(songFile)")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            currentSong = songFile
            isPlaying = true
        } catch {
            print("Error playing \(songFile): \(error)")
            isPlaying = false
        }
    }
}
