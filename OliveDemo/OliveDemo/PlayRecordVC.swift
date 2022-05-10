import UIKit
import AVFoundation

class PlayRecordVC: UIViewController, AVAudioRecorderDelegate {

    let audioSession = AVAudioSession.sharedInstance()
    let player = AVAudioPlayerNode()
    let engine = AVAudioEngine()

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [.allowBluetooth])
            try audioSession.setMode(.default)
            try audioSession.setActive(true)
        } catch {
        print(error)
        }
        
        let input = engine.inputNode

        engine.attach(player)

        let bus = 0
        let inputFormat = input.inputFormat(forBus: bus)

        engine.connect(player, to: engine.mainMixerNode, format: inputFormat)

        input.installTap(onBus: bus, bufferSize: 512, format: inputFormat) { (buffer, time) -> Void in
            self.player.scheduleBuffer(buffer)
            print(buffer)
        }
    }

    @IBAction func start(_ sender: UIButton) {
        print("play")
        do {
            try engine.start()
        } catch {
            print(error)
        }
        player.play()
        
    }

    @IBAction func stop(_ sender: UIButton) {
        print("stop")
        engine.stop()
        player.stop()
    }

}
