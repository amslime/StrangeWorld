//
//  HealthBar.swift
//  StrangeWorld
//
//  Created by wangli on 16/8/17.
//  Copyright © 2016年 wangli. All rights reserved.
//

import Foundation
import SpriteKit

class HealthBar : SKSpriteNode {
    var barLength: CGFloat!
    var mhp: Int!
    var hp: Int!
    convenience init(barLengthed length : CGFloat, barHeight h : CGFloat, maxHp mhp : Int, currentHp hp : Int) {
        self.init(color : SKColor.redColor(), size : CGSize(width: length * CGFloat(hp) / CGFloat(mhp), height: h))
        self.mhp = mhp
        self.hp = hp
        self.barLength = length
        self.zPosition = 30
    }
    
    func damaged(damHp : Int)
    {
        hp = max(hp - damHp, 0)
        self.runAction(SKAction.resizeToWidth(barLength * CGFloat(hp) / CGFloat(mhp), duration: 0.3))
    }
    
}
