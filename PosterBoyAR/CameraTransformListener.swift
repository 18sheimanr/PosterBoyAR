//
//  CameraTransformListener.swift
//  PosterBoyAR
//
//  Created by Robert Sheiman on 1/8/18.
//  Copyright © 2018 Robert Sheiman. All rights reserved.
//

import Foundation
import ARKit

class CameraTransformListener: NSObject, ARSessionDelegate{
    
    var currentCameraTransform: SCNMatrix4!
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        currentCameraTransform = SCNMatrix4(frame.camera.transform)
    }
    
    func getCameraTransform() -> SCNMatrix4{
        return currentCameraTransform
    }
    
}
