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
    let popSound = SKAction.playSoundFileNamed("pop", waitForCompletion: false)
    
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
            //Set falldown actions
            let moveDown =  SKAction.move(to: CGPoint(x: node.position.x - 5, y: node.position.y - 100), duration: 0.4)
            let moveLeftDown =  SKAction.move(to: CGPoint(x: node.position.x - 20, y: node.position.y - 140), duration: 0.3)
            let moveRightDown =  SKAction.move(to: CGPoint(x: node.position.x + 20, y: node.position.y - 140), duration: 0.3)
            let moveToBottom =  SKAction.move(to: CGPoint(x: node.position.x + 45, y: node.position.y - 220), duration: 0.3)
            
            //make some balloons float to the left and some to the right when falling
            let moveDownFloating = ((arc4random() % 2)==0) ? moveLeftDown : moveRightDown
            
            let sequence = SKAction.sequence([popSound, moveDown, moveDownFloating, moveToBottom])
            let fadeOut = SKAction.fadeOut(withDuration: 1.0)
            let groupAction = SKAction.group([sequence,fadeOut])
            
            node.run(groupAction){
                //callback to delete node
                node.removeFromParent()
            }
        } else {
            guard let sceneView = self.view as? ARSKView else {
                return
            }
            
            // Create anchor using the camera's current position
            if let currentFrame = sceneView.session.currentFrame {
                
                // Create a transform with a translation of 0.4 meters in front of the camera
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
