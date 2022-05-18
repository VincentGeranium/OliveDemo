//
//  AudioInputNode.swift
//  OliveDemo
//
//  Created by Kwangjun Kim on 2022/05/18.
//

import Foundation
import AVFAudio

struct AudioInputNode {
    let engine = AVAudioEngine()
    let player = AVAudioPlayerNode()
    let audioFormat = AVAudioFormat()
    
    func install() {
        install(audioEngine: engine, playerNode: player, audioFormat: audioFormat)
    }
}

// MARK: - Private extension for AudioInputNode Install method.
private extension AudioInputNode {
    // MARK: - install method
    private func install(audioEngine: AVAudioEngine, playerNode: AVAudioPlayerNode, audioFormat: AVAudioFormat) {
        let inputNode = audioEngine.inputNode
        audioEngine.attach(playerNode)
        
        let bus = 0
        var audioFormat = audioFormat
        audioFormat = inputNode.inputFormat(forBus: bus)
        
        audioEngine.connect(playerNode, to: audioEngine.mainMixerNode, format: audioFormat)
        
        inputNode.installTap(onBus: bus, bufferSize: 512, format: audioFormat) { (buffer, time) -> Void in
            playerNode.scheduleBuffer(buffer)
//            print(buffer)
        }
    }
}
