//
//  Poster.swift
//  PosterBoyAR
//
//  Created by Robert Sheiman on 1/8/18.
//  Copyright © 2018 Robert Sheiman. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import ARKit

class Poster: SCNNode{
    
    var image: UIImage!
    var planeGeometry: SCNPlane!
    
    init(image: UIImage, width: CGFloat, height: CGFloat, transform: SCNMatrix4){
        super.init()
        self.image = image
        self.transform = transform
        updateGeometry(width: width, height: height)
        planeGeometry.materials = [initializePlaneMaterial(image: image)]
    }
    
    required init?(coder c: NSCoder) {
        super.init(coder: c)
    }
    
    func updateGeometry(width: CGFloat, height: CGFloat){
        planeGeometry = SCNPlane(width: width, height: height)
        let planeNode = SCNNode(geometry: self.planeGeometry)
        planeNode.position = SCNVector3(0, 0, 0)
        planeNode.transform = transform
        updatePlaneMaterialDimensions()
        self.addChildNode(planeNode)
    }
    
    func initializePlaneMaterial(image: UIImage) -> SCNMaterial {
        let planeMaterial = SCNMaterial()
        planeMaterial.diffuse.contents = image
        planeMaterial.isDoubleSided = true
        return planeMaterial
    }
    
    func updatePlaneMaterialDimensions() {
        // get material
        let material = self.planeGeometry.materials.first!
        // scale material to width and height of the updated plane
        let width = Float(self.planeGeometry.width)
        let height = Float(self.planeGeometry.height)
        material.diffuse.contentsTransform = SCNMatrix4MakeScale(width, height, 1.0)
    }
    
}
