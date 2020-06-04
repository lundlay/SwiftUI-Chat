//
//  Speak.swift
//  Victoria-Chat
//
//  Created by Oleg Lavronov on 6/4/20.
//  Copyright © 2020 Lundlay. All rights reserved.
//

import AVFoundation

struct Speak {
    
    static func say(message: String?) {
        guard let message = message else { return }
        guard let voice = AVSpeechSynthesisVoice(language: "en-US") else { return }

        let utterance = AVSpeechUtterance(string: message)
        utterance.voice = voice

        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)

    }
    
}

