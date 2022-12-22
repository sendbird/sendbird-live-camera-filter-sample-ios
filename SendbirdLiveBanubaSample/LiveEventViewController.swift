//
//  LiveEventViewController.swift
//  SendbirdLiveBanubaSample
//
//  Created by Minhyuk Kim on 2022/12/09.
//

import UIKit
import BNBSdkApi
import SendbirdLiveSDK

class LiveEventViewController: UIViewController {
    @IBOutlet weak var localVideo: EffectPlayerView!
    @IBOutlet var liveEventIdLabel: UILabel!
    
    var liveEvent: LiveEvent!
    private var sdkManager = BanubaSdkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        liveEventIdLabel.text = liveEvent.liveEventId
        
        BanubaSdkManager.initialize(
            resourcePath: [Bundle.main.bundlePath + "/bnb-resources",
                           Bundle.main.bundlePath + "/effects"],
            clientTokenString: banubaClientToken
        )
        
        let config = EffectPlayerConfiguration()
        config.fpsLimit = 30
        self.sdkManager.setup(configuration: config)
        self.sdkManager.setRenderTarget(view: self.localVideo, playerConfiguration: config)
        
        self.sdkManager.output?.startForwardingFrames(handler: { (pixelBuffer) -> Void in
            self.liveEvent.enqueueExternalVideoFrame(pixelBuffer, timestamp: CMClockGetTime(CMClockGetHostTimeClock()))
        })
    }
    
    @IBAction func exitLiveEvent(_ sender: Any) {
        (sender as? UIButton)?.isEnabled = false
        liveEvent.endEvent { _ in
            self.dismiss(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sdkManager.effectManager()?.setEffectVolume(0)
        sdkManager.input.startCamera()
        _ = sdkManager.loadEffect("TrollGrandma")
        sdkManager.startEffectPlayer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sdkManager.input.stopCamera()
        sdkManager.stopEffectPlayer()
    }
}
