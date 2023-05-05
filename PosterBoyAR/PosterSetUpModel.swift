//
//  PosterSetUpModel.swift
//  PosterBoyAR
//
//  Created by Robert Sheiman on 1/8/18.
//  Copyright © 2018 Robert Sheiman. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

class PosterSetUpModel{
    
    var VC: ViewController?
    let defaultWidth: CGFloat = 0.3
    var posterToAdd: Poster?
    let cameraTransformListener = CameraTransformListener()
    let phoneAgainstWallListener = PhoneAgainstWallListener()

    func setUp(VC: ViewController){
        self.VC = VC
        phoneAgainstWallListener.model = self
    }
    
    func selectImageForPoster(){
        let photoSelector = PhotoSelector(presentOver: VC!, imageFor: self)
        photoSelector.openPhotoPicker()
    }
    
    func setUpPosterWithImage(_ image: UIImage){
        print("got image")
        let defaultHeight = (image.size.height/image.size.width)*defaultWidth
        posterToAdd = Poster(image: image, width: defaultWidth, height: defaultHeight, transform: SCNMatrix4())
        VC!.showInstructions()
        phoneAgainstWallListener.start(reportTo: self)
        VC?.sceneView.session.delegate = cameraTransformListener
    }
    
    func deviceIsAgainstWall(){
        print("Device found to be against a wall")
        VC!.hideInstructions()
        phoneAgainstWallListener.stop()
        VC?.sceneView.session.delegate = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.posterToAdd!.transform = self.cameraTransformListener.getCameraTransform()
            self.posterToAdd!.rotation.x = 0 //makes it aligned against wall
            self.posterToAdd!.rotation.z = 0 //makes it is straight
            self.VC!.addPoster(self.posterToAdd!)
            self.posterToAdd = nil //means there is no new poster to add now
        })
    }
    
}
