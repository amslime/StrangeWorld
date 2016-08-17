//
//  Battler.swift
//  StrangeWorld
//
//  Created by wangli on 16/8/16.
//  Copyright © 2016年 wangli. All rights reserved.
//

import Foundation
import SpriteKit

class Battler: SKSpriteNode {
    var scaleFac : CGFloat!
    var creatureStats: Creature!
    var isPlayer : Bool!
    var delegate : BattleMainScene?
    var attackRate : Int!
    var hpRecoverRate : Float!
    var turns : Int!
    
    convenience init(stats: Creature, isPlayer : Bool) {
        self.init(imageNamed: stats.battleImg)
        //self.userInteractionEnabled = true
        self.isPlayer = isPlayer
        self.creatureStats = stats
        scaleFac = 1.0
        self.setScale(scaleFac)
        self.zPosition = 30
        
        self.attackRate = updateAttackRate()
        self.hpRecoverRate = updateHpRecoverRate()
        self.turns = self.attackRate
    }
    
    func updateAttackRate() -> Int {
        return max(10, 10000/(50 + creatureStats.dex))
    }
    
    func updateHpRecoverRate() -> Float {
        return 0.03 + Float(creatureStats.str) * 0.002
    }
    
    func stab(distance dist: CGFloat) {
        NSLog("Stabing")
        turns = turns + attackRate
        let orgX = self.position.x
        var dstX: CGFloat!
        if (isPlayer == true) {
            dstX = orgX + dist
        } else {
            dstX = orgX - dist
        }
        self.runAction(SKAction.sequence([SKAction.moveToX(dstX, duration: 1), SKAction.runBlock{
                self.delegate?.hit(self.isPlayer)
            },SKAction.moveToX(orgX, duration: 1.0)]), completion : {
                self.delegate?.nextAction()
            }
        )
    }
    
}