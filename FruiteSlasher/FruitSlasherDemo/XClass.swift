//
//  XMarks.swift
//  FruitNinjaDemo
//
//  Created by Michael on 26/04/19.
//  Copyright © 2019 Michael. All rights reserved.
//

import Foundation
import SpriteKit
class  XClass: SKNode {
    var xNodeArray = [SKSpriteNode]()
    var numX = Int()
    let blackX = SKTexture(imageNamed: "x black")
    let redX = SKTexture(imageNamed: "x red")
    
    // Create X symbol In Right side corner.
    init(num:Int = 0) {
        super.init()
        numX = num
        for i in 0 ..< num {
            let xMark = SKSpriteNode(imageNamed: "x black")
            xMark.size = CGSize(width: 60, height: 60)
            xMark.position.x = -CGFloat(i)*70
            addChild(xMark)
            // Add Xmark in array
            xNodeArray.append(xMark)
            
        }
        
    }
    
    
    // Update Xnode Array in Misses Count plus
    // Update black X image to red
    func update(num: Int)  {
        if num <= numX {
            xNodeArray[xNodeArray.count-num].texture = redX

        }
    }
    
    // Restart game than call this function
    // rearrange black X Image
    func restart() {
        for xMark in xNodeArray{
            xMark.texture = blackX
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
