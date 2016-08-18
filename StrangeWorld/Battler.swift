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
    private var scaleFac : CGFloat!
    private var attackRate : Int!
    private var hpRecoverRate : Float!
    
    var creatureStats: Creature!
    var isPlayer : Bool!
    weak var delegate : BattleMainScene?
    var turns : Int!
    var die : Bool!
    
    convenience init(stats: Creature, isPlayer : Bool) {
        self.init(imageNamed: stats.battleImg)
        //self.userInteractionEnabled = true
        self.isPlayer = isPlayer
        self.creatureStats = stats
        scaleFac = 1.0
        self.setScale(scaleFac)
        self.zPosition = 30
        self.die = false
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
    
    func goDie() {
        self.runAction(SKAction.rotateByAngle(-100, duration: 2))
        self.runAction(SKAction.scaleTo(0, duration: 2), completion : {
            self.hidden = true
        })
        self.die = true
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
    
    func retreat(distance dist: CGFloat, level lv: Int) -> Bool {
        NSLog("Retreating")
        turns = turns + attackRate
        let orgX = self.position.x
        var dstX: CGFloat!
        if (isPlayer == true) {
            dstX = orgX - dist
        } else {
            dstX = orgX + dist
        }
        var succ: Bool = false
        let seed = Int(arc4random_uniform(UInt32(lv + creatureStats.dex)))
        if (seed > lv) {
            succ = true
        }
        self.runAction(SKAction.sequence([SKAction.moveToX(dstX, duration: 1), SKAction.runBlock{
                if (succ == true) {
                    self.hidden = true
                    self.delegate?.retrectSucc()
                }
            },SKAction.moveToX(orgX, duration: 1.0)]), completion : {
                self.delegate?.nextAction()
            }
        )
        return succ
    }
}