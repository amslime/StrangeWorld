//
//  BattleMainScene.swift
//  StrangeWorld
//
//  Created by wangli on 16/8/16.
//  Copyright © 2016年 wangli. All rights reserved.
//

import UIKit
import SpriteKit

class BattleMainScene: SKScene {
    var stabDist: CGFloat = 100.0
    var barLength: CGFloat = 200.0
    var player: Battler!
    var enemy: Battler!
    var playerStat: Player!
    var enemyStat: Enemy!
    var playerHealthBar, enemyHealthBar: HealthBar!
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = SKColor.init(colorLiteralRed: 0.7, green: 0.9, blue: 0.9, alpha: 1.0)
        doBattle()
    }
    
    func doBattle() {
        playerStat = ModelHandler.Instance.player
        enemyStat = Enemy()
        enemyStat.load(enemyID: "RAT")
        player = Battler(stats: playerStat, isPlayer: true)
        enemy = Battler(stats: enemyStat, isPlayer: false)
        stabDist = self.frame.width * 0.4
        barLength = self.frame.width * 0.4
        player.position = CGPoint(x:CGRectGetMidX(self.frame) - self.frame.width * 0.25, y:CGRectGetMidY(self.frame) - self.frame.height * 0.1)
        enemy.position = CGPoint(x:CGRectGetMidX(self.frame) + self.frame.width * 0.25, y:CGRectGetMidY(self.frame) - self.frame.height * 0.1)
        
        playerHealthBar = HealthBar(barLengthed: barLength, maxHp: playerStat.mhp, currentHp: playerStat.mhp)
        playerHealthBar.position = CGPoint(x: CGRectGetMidX(self.frame) - self.frame.width * 0.25, y: CGRectGetMidY(self.frame) + self.frame.height * 0.4)
        enemyHealthBar = HealthBar(barLengthed: barLength, maxHp: enemyStat.mhp, currentHp: enemyStat.mhp)
        enemyHealthBar.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.width * 0.25, y: CGRectGetMidY(self.frame) + self.frame.height * 0.4)
        
        self.addChild(player)
        self.addChild(enemy)
        self.addChild(playerHealthBar)
        self.addChild(enemyHealthBar)
        player.delegate = self
        enemy.delegate = self
        nextAction()
    }
    
    func hit(isPlayer : Bool) {
        var attacker, defender : Creature
        if (isPlayer == true) {
            attacker = player.creatureStats
            defender = enemy.creatureStats
        } else {
            attacker = enemy.creatureStats
            defender = player.creatureStats
        }
        
        let baseDam = UInt32(attacker.dmgMin) + arc4random_uniform(UInt32(attacker.dmgRange + 1))
        let reduction = max(0, defender.def - attacker.dex)
        let finalDam = max(1, Int(baseDam) - reduction)
        
        if (isPlayer == true) {
            enemyHealthBar.damaged(finalDam)
        } else {
            playerHealthBar.damaged(finalDam)
        }
    }
    
    func nextAction() {
        if (player.turns < enemy.turns) {
            player.stab(distance: stabDist)
        } else {
            enemy.stab(distance: stabDist)
        }
    }
}
