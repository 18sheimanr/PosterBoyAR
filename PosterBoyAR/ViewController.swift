//
//  ViewController.swift
//  PosterBoyAR
//
//  Created by Robert Sheiman on 1/8/18.
//  Copyright © 2018 Robert Sheiman. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var instructions: UILabel!
    @IBOutlet var sceneView: ARSCNView!
    let posterSetUp = PosterSetUpModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = SCNScene()
        sceneView.scene = scene
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        posterSetUp.selectImageForPoster()
    }
    
    func showInstructions(){
        instructions.isHidden = false
    }
    
    func hideInstructions(){
        instructions.isHidden = true
    }
    
    func addPoster(_ poster: Poster){
        print("Adding poster into sceneView")
        sceneView.scene.rootNode.addChildNode(poster)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        instructions.isHidden = true
        posterSetUp.setUp(VC: self)
        sceneView.delegate = self
        sceneView.session.delegate = posterSetUp.cameraTransformListener
        sceneView.showsStatistics = true
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
