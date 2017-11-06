//
//  ViewController.swift
//  GraphDeepFirstSearch
//
//  Created by Tymofii Dolenko on 11/6/17.
//  Copyright © 2017 Tymofii Dolenko. All rights reserved.
//

import UIKit
import SpriteKit

class MainVC: UIViewController {
    
    @IBOutlet weak var skView: SKView!
    
    var scene: GraphScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        scene = GraphScene(size: self.view.bounds.size)
        scene.scaleMode = .resizeFill
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
    }

    @IBAction func addBubbleTapped(_ sender: Any) {
        scene.addBubble()
    }
    
}

