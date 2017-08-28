//
//  Scene.swift
//  ARBalloons
//
//  Created by Marla Na on 29.08.17.
//  Copyright © 2017 Marla Na. All rights reserved.
//

import SpriteKit
import ARKit

class Scene: SKScene {
    
    override func didMove(to view: SKView) {
        // Setup your scene here
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Get first touch
        guard let touch = touches.first else {
            return
        }
        // Get location in the scene
        let location = touch.location(in: self)
        
        // Get the nodes at the clicked location
        let clicked = nodes(at: location)
        
        // Get the first node
        if let node = clicked.first {
            //Set falldown action and fade as a group
            let move =  SKAction.move(to: CGPoint(x: node.position.x - 5, y: node.position.y - 200), duration: 0.7)
            let fadeOut = SKAction.fadeOut(withDuration: 0.7)
            let groupAction = SKAction.group([move,fadeOut])
            
            node.run(groupAction){
                //callback to delete node
                node.removeFromParent()
            }
        } else {
        //create new balloon if elsewhere selected
        guard let sceneView = self.view as? ARSKView else {
            return
        }
        
        // Create anchor using the camera's current position
        if let currentFrame = sceneView.session.currentFrame {
            
            // Create a transform with a translation of 0.2 meters in front of the camera
            var translation = matrix_identity_float4x4
            translation.columns.3.z = -0.4
            let transform = simd_mul(currentFrame.camera.transform, translation)
            
            // Add a new anchor to the session
            let anchor = ARAnchor(transform: transform)
            sceneView.session.add(anchor: anchor)
        }
        }
    }
}
