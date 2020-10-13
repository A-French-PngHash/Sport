//
//  PlayerView.swift
//  sport
//
//  Created by Titouan Blossier on 11/10/2020.
//  Copyright © 2020 Titouan Blossier. All rights reserved.
//

// Code from https://stackoverflow.com/a/61425000/11692500

import AVFoundation
import UIKit

class PlayerView: UIView {

    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }

    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }

    // Override UIView property
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}
