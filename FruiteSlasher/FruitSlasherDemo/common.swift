//
//  Helping Function.swift
//  FruitNinjaDemo
//
//  Created by Michael on 25/04/19.
//  Copyright © 2019 Michael. All rights reserved.
//

import Foundation
import UIKit

func randomCGFloat (_ lower:CGFloat, _ upper:CGFloat ) -> CGFloat {
    return lower + CGFloat(arc4random()) / CGFloat(UInt32.max) * (upper - lower)
}
