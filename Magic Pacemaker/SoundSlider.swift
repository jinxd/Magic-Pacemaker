//
//  SoundSlider.swift
//  Magic Pacemaker
//
//  Created by Hannes Nagel on 8/17/24.
//

import SwiftUI
import AVFoundation

@Observable
class SoundManager{
    var volume = 0.75
    var frequency = 4.0
    private let player : AVAudioPlayer
    private let player2 : AVAudioPlayer
    
    init?(){
        let string = Bundle.main.path(forResource: "Beep", ofType: "mp3")!
        let url = URL(string: string)!
        if let player = try? AVAudioPlayer(contentsOf: url),
        let player2 = try? AVAudioPlayer(contentsOf: url){
            self.player = player
            self.player2 = player2
        } else {
            return nil
        }
        try? setActive()
        Task{
            player.prepareToPlay()
            player2.prepareToPlay()
            await schedulePlay()
        }
    }
    func schedulePlay() async {
        player2.stop()
        player.volume = Float(volume)
        player.play()
        player2.prepareToPlay()
        try? await Task.sleep(for: .seconds(1/frequency))
        await scheduleOtherPlay()
    }
    func scheduleOtherPlay() async {
        player.stop()
        player2.volume = Float(volume)
        player2.play()
        player.prepareToPlay()
        try? await Task.sleep(for: .seconds(1/frequency))
        await schedulePlay()
    }
    func setActive() throws {
        if !AVAudioSession.sharedInstance().isOtherAudioPlaying{
            try AVAudioSession.sharedInstance().setActive(true)
        }
        try AVAudioSession.sharedInstance().setCategory(.playback, options: [.mixWithOthers])
    }
    
}

struct SoundSlider: View {
    @State var soundManager = SoundManager()!
    var body: some View{
        HStack{
            SingleSlider("Volume", value: $soundManager.volume, in: 0...1)
            SingleSlider("Frequency", value: $soundManager.frequency, in: 1...5)
        }
    }
}

#Preview {
    SoundSlider()
}
