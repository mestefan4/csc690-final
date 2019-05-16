//
//  Fruite.swift
//  FruitNinjaDemo
//
//  Created by Michael on 25/04/19.
//  Copyright © 2019 Michael. All rights reserved.
//

import Foundation
import SpriteKit

class MakeFruits: SKSpriteNode {
    
    var type = ""
    
   init() {
        var texture : SKTexture
    
    //Make Random Node (Fruits or Bomb) Using random Number
        if randomCGFloat(0, 1) < 0.9{
            type = "fruit"
            let allFruitsName = ["img1.png","img2.png","img3.png","img4.png","img5.png","img6.png"]
            let n = Int(arc4random_uniform(UInt32(allFruitsName.count)))
            let imageName = allFruitsName[n]
            texture = SKTexture(image: UIImage(named: imageName)!)
        }else{
            type = "bomb"
            texture = SKTexture(image: UIImage(named: "bomb.png")!)
            
            
        }
    
        super.init(texture: texture, color: .blue, size: texture.size())
        self.physicsBody = SKPhysicsBody()
        self.name = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
