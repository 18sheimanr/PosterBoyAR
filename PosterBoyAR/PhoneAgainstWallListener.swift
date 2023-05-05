//
//  PhoneAgainstWallListener.swift
//  PosterBoyAR
//
//  Created by Robert Sheiman on 1/8/18.
//  Copyright © 2018 Robert Sheiman. All rights reserved.
//

import Foundation
import AVKit

class PhoneAgainstWallListener{
    
    var model: PosterSetUpModel?
    
    func start(reportTo: PosterSetUpModel) {
        let device = UIDevice.current
        device.isProximityMonitoringEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(proximityChanged), name: .UIDeviceProximityStateDidChange, object: device)
        //▼ for testing
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0, execute: {
            self.model?.deviceIsAgainstWall()
        })
        //▲ for testing
    }
    
    @objc func proximityChanged() {
        let device = UIDevice.current
        if device.proximityState == true{
            model?.deviceIsAgainstWall()
        }
    }
    
    func stop(){
        let device = UIDevice.current
        device.isProximityMonitoringEnabled = false
        NotificationCenter.default.removeObserver(self, name: .UIDeviceProximityStateDidChange, object: nil)
    }
}
