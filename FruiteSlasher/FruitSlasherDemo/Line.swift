//
//  TrailLine.swift
//  FruitNinjaDemo
//
//  Created by Michael on 26/04/19.
//  Copyright © 2019 Michael. All rights reserved.
//

import Foundation
import SpriteKit

class Line: SKShapeNode {
    var shrinktimer = Timer()
    // Line Config (line start position, line end position, path, and color)
    init(pos:CGPoint, lastpos: CGPoint, width:CGFloat, color:UIColor) {
        super.init()
        // make Line 
        let path = CGMutablePath()
        path.move(to: pos)
        path.addLine(to: lastpos)
        
        self.path = path
        lineWidth = width
        strokeColor = color
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
