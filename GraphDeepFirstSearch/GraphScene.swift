//
//  GraphScene.swift
//  GraphDeepFirstSearch
//
//  Created by Tymofii Dolenko on 11/6/17.
//  Copyright © 2017 Tymofii Dolenko. All rights reserved.
//

import UIKit
import SpriteKit

let blue = UIColor(red: 47.0/255.0, green: 160.0/255.0, blue: 210.0/255.0, alpha: 1.0)
let darkBlue = UIColor(red: 1.0/255.0, green: 97.0/255.0, blue: 132.0/255.0, alpha: 1.0)

class GraphScene: SKScene {
    
    var bubbleCount = 0
    
    let cameraNode = SKCameraNode()
    var deltaPoint = CGPoint(x: 0, y: 0)
    var selectedNode: SKShapeNode?
    var tapTimer: Timer?
    
    var isCameraMoving: Bool = false

    @objc func handlePinch(recognizer: UIPinchGestureRecognizer) {
        if let camera = camera {
            if camera.xScale > 2 || camera.yScale < 0.4 || camera.yScale > 2 || camera.yScale < 0.4 {
                camera.run(SKAction.scale(to: CGSize(width: 1.0, height: 1.0), duration: 0.5))
            } else {
                camera.run(SKAction.scale(by: recognizer.scale, duration: 0))
            }
            recognizer.scale = 1
        }
    }
    
    override func didMove(to view: SKView) {
        cameraNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        camera = cameraNode
        addChild(cameraNode)
        let precog = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(recognizer:)))
        self.view?.addGestureRecognizer(precog)
        
        backgroundColor = SKColor.white
        
    }
    
    func cleanUpScene() {
        self.removeAllChildren()
        addChild(cameraNode)
    }
    
    func addBubble() {
        bubbleCount += 1
        
        let bubble = SKShapeNode(circleOfRadius: 20)
        bubble.name = bubbleCount.description
        bubble.fillColor = blue
        bubble.strokeColor = blue
        bubble.position = getRandomSpot()
        
        bubble.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        bubble.physicsBody?.isDynamic = false
        bubble.physicsBody?.allowsRotation = false
        
        let nameLabel = SKLabelNode(text: bubbleCount.description)
        
        nameLabel.fontName = "AvenirNext-Regular"
        nameLabel.fontSize = 17
        nameLabel.fontColor = .white
        nameLabel.verticalAlignmentMode = .center
        nameLabel.horizontalAlignmentMode = .center
        
        nameLabel.position = CGPoint(x: 0, y: 0)
        bubble.addChild(nameLabel)
        addChild(bubble)
        
    }
    
    func getRandomSpot() -> CGPoint {
        let spots: [CGFloat] = [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9]
        let randWidth = Int(arc4random_uniform(UInt32(spots.count)))
        let randHeight = Int(arc4random_uniform(UInt32(spots.count)))
        let spotWidth = spots[randWidth]
        let spotHeight = spots[randHeight]
        let point = CGPoint(x: self.size.width * spotWidth, y: self.size.height * spotHeight)
        return point
    }
    
    func handleHoldingTap(timer: Timer) {
        if let selectedNode = timer.userInfo as? SKShapeNode {
            self.selectedNode = selectedNode
            selectedNode.fillColor = UIColor.blue
            selectedNode.strokeColor = UIColor.blue
        }
    }
    
    func holdingEnded() {
        deltaPoint = CGPoint(x: 0, y: 0)
        selectedNode?.fillColor = blue
        selectedNode?.strokeColor = blue
        selectedNode = nil
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        let previousLocation = touch.previousLocation(in: self)
        
        if let _ = selectedNode {
            deltaPoint = CGPoint(x: location.x - previousLocation.x, y: location.y - previousLocation.y)
        } else {
            if let camera = camera {
                isCameraMoving = true
                if camera.position.x > 0 && camera.position.x < size.width && camera.position.y > 0 && camera.position.y < size.height {
                    camera.position.x += location.x - previousLocation.x
                    camera.position.y += location.y - previousLocation.y
                    
                } else {
                    let center = CGPoint(x: size.width / 2, y: size.height / 2)
                    camera.run(SKAction.move(to: center, duration: 0.5))
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            
            // detect touch in the scene
            let location = touch.location(in: self)
            
            if let node = self.atPoint(location) as? SKShapeNode {
                self.selectedNode = node
                self.selectedNode?.fillColor = darkBlue
                self.selectedNode?.strokeColor = darkBlue
            }
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isCameraMoving = false
        tapTimer?.invalidate()
        holdingEnded()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        tapTimer?.invalidate()
        holdingEnded()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let selected = selectedNode {
            let newPoint = CGPoint(x: selected.position.x + self.deltaPoint.x, y: selected.position.y + self.deltaPoint.y)
            selected.position = newPoint
            deltaPoint = CGPoint(x: 0, y: 0)
        }
    }
    
}
