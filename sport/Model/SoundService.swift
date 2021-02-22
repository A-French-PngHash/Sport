//
//  SoundService.swift
//  sport
//
//  Created by Titouan Blossier on 15/02/2021.
//  Copyright © 2021 Titouan Blossier. All rights reserved.
//

import Foundation
import AVFoundation

/// Class used to play sounds.
class SoundService {
    /// Audio player playing the sounds.
    private let audioPlayer : AVQueuePlayer
    /// Notification center used to receive update on sound finishing to play. Not using the default instance to allow different SoundService to be playing at the same time.
    private let notificationCenter = NotificationCenter()

    /// Track the number of sounds played for this session.
    private var numberOfSoundPlayed : Int = 0
    /// Sounds to play.
    private let sounds : Array<AVPlayerItem>
    /// Escaping closure called when all the sounds have finished playing.
    private let finishedPlaying : () -> Void

    /// Init of sound service. Sound begin to play as soon as the class is created.
    ///
    /// - parameter sounds : Array of the name of the sound file to play. AVPlayerItem are then created from those names. Extension must be mp3.
    /// - parameter finishedPlaying : Escaping closure called when all the sounds have finished playing.
    ///
    init(_ soundsName : Array<String>, finishedPlaying : @escaping () -> Void) {
        self.sounds = []
        for name in soundsName {
            self.sounds.append(AVPlayerItem.init(url: Bundle.main.url(forResource: name, withExtension: "mp3")!))
        }

        self.finishedPlaying = finishedPlaying

        notificationCenter.addObserver(self, selector: #selector(itemDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)

        let audioPlayer = AVQueuePlayer(items: self.sounds)
        audioPlayer.play()

    }

    @objc func itemDidFinishPlaying() {
        numberOfSoundPlayed += 1
        if numberOfSoundPlayed == sounds.count {
            finishedPlaying()
        }
    }
}
