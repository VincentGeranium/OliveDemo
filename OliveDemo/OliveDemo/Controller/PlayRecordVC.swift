import UIKit
import AVFoundation

class PlayRecordVC: UIViewController {
    
    let audioSession = AVAudioSession.sharedInstance()
    var audioInputNode: AudioInputNode = AudioInputNode()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioSessionSetup()
        audioInputNode.install()
    }
}

// MARK: - extension for audioSession setup
extension PlayRecordVC {
    
    // MARK: - AVAudioSession initialized setup method.
    func audioSessionSetup() {
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [.allowBluetooth])
            try audioSession.setMode(.voicePrompt)
            try audioSession.setActive(true)
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - extension for Button Action
extension PlayRecordVC {
    
    // MARK: - Start Button action method.
    /// When user tapped start button, activated this function.
    @IBAction func start(_ sender: UIButton) {
        print("play")
        do {
            try audioInputNode.engine.start()
        } catch {
            print(error.localizedDescription)
        }
        audioInputNode.player.play()
    }
    
    // MARK: - Stop Button action method.
    /// When user tapped stop button, activated this function.
    @IBAction func stop(_ sender: UIButton) {
        print("stop")
        audioInputNode.engine.stop()
        audioInputNode.player.stop()
    }
}
