//
//  CreateLiveEventViewController.swift
//  SendbirdLiveBanubaSample
//
//  Created by Minhyuk Kim on 2022/12/12.
//

import UIKit
import SendbirdLiveSDK

class CreateLiveEventViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createLiveEvent(_ sender: Any) {
        SendbirdLive.createLiveEvent(config: .init(userIdsForHost: [])) { result in
            switch result {
            case .success(let liveEvent):
                liveEvent.enterAsHost(options: MediaOptions(turnVideoOn: true, turnAudioOn: true, streamWithExternalVideo: true)) { _ in
                    liveEvent.startEvent(mediaOptions: nil) { _ in
                        self.performSegue(withIdentifier: "EnterLiveEvent", sender: liveEvent)
                    }
                }
            case .failure: break
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let liveEventViewController = segue.destination as? LiveEventViewController,
              let liveEvent = sender as? LiveEvent else { return }
        
        liveEventViewController.liveEvent = liveEvent
    }
}
