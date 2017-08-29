//
//  ViewController.swift
//  ARBalloons
//
//  Created by Marla Na on 29.08.17.
//  Copyright © 2017 Marla Na. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit

class ViewController: UIViewController, ARSKViewDelegate {
    
    @IBOutlet var sceneView: ARSKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        // Load the SKScene from 'Scene.sks'
        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
        // Run the view's session
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
    
    // MARK: - ARSKViewDelegate
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        // Create and configure a node for the anchor added to the view's session.
        let spriteNode = SKSpriteNode(imageNamed: "balloon")
        
        let fadeOut = SKAction.fadeOut(withDuration: 2.6)
        let fadeIn = SKAction.fadeIn(withDuration: 2.6)
        let fade = SKAction.sequence([fadeOut, fadeIn])
        let fadeForever = SKAction.repeatForever(fade)
        
        let pulseUp = SKAction.scale(to: 5.0, duration: 1.0)
        let pulseDown = SKAction.scale(to: 3.0, duration: 1.0)
        let pulse = SKAction.sequence([pulseUp, pulseDown])
        let pulseForever = SKAction.repeatForever(pulse)
        
        //execute both actions simultaneously
        let group = SKAction.group([fadeForever, pulseForever])
        spriteNode.run(group)

        return spriteNode;
    }
    
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
