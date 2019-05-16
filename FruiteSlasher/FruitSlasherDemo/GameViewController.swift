//
//  GameViewController.swift
//  FruitNinjaDemo
//
//  Created by Michael on 25/04/19.
//  Copyright © 2019 Michael. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import Foundation

class GameViewController: UIViewController {
    
//    let deviceWidth = UIScreen.main.bounds.width
//    let deviceHeight = UIScreen.main.bounds.height
//    var maxAspectRatio: CGFloat = 0.0
//    var playableArea: CGRect

 
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
//        maxAspectRatio = deviceHeight / deviceWidth
//
//        let playableHeight = self.view.frame.width / maxAspectRatio
//        let playableMargin = (self.view.frame.height - playableHeight) / 2.0
//        playableArea = CGRect(x: 0, y: playableMargin, width: self.view.frame.width, height: playableHeight)
//
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {

                
                // Set Size in All device
                let size = CGSize(width: view.bounds.size.width * 2 , height: view.bounds.size.height * 2)
                scene.size = size
                scene.scaleMode = .aspectFill
                
                
                // Present the game scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
   // status bar hidden
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
