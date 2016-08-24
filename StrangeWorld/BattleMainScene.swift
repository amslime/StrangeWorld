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
    private var isRetreating: Bool!
    private var retreated: Bool!
    private var stabDist: CGFloat = 100.0
    private var barLength: CGFloat = 200.0
    private var barHeight: CGFloat = 30.0
    private var player: Battler!
    private var enemy: Battler!
    private var playerStat: Player!
    private var enemyStat: Enemy!
    private var playerHealthBar, enemyHealthBar: HealthBar!
    
    override func didMoveToView(view: SKView) {
        NSLog("move to view")
        self.backgroundColor = SKColor.init(colorLiteralRed: 0.7, green: 0.9, blue: 0.9, alpha: 1.0)
        doBattle()
    }
    
    func doBattle() {
        isRetreating = false
        retreated = false
        playerStat = ModelHandler.Instance.player
        enemyStat = Enemy()
        enemyStat.load(enemyID: "RAT")
        player = Battler(stats: playerStat, isPlayer: true, preferedWidth: self.frame.width * 0.33)
        enemy = Battler(stats: enemyStat, isPlayer: false, preferedWidth: self.frame.width * 0.33)
        stabDist = self.frame.width * 0.4
        barLength = self.frame.width * 0.4
        barHeight = self.frame.height * 0.04
        player.position = CGPoint(x:CGRectGetMidX(self.frame) - self.frame.width * 0.25, y:CGRectGetMidY(self.frame) - self.frame.height * 0.1)
        enemy.position = CGPoint(x:CGRectGetMidX(self.frame) + self.frame.width * 0.25, y:CGRectGetMidY(self.frame) - self.frame.height * 0.1)
        
        playerHealthBar = HealthBar(barLengthed: barLength, barHeight: barHeight, maxHp: playerStat.mhp, currentHp: playerStat.hp)
        playerHealthBar.position = CGPoint(x: CGRectGetMidX(self.frame) - self.frame.width * 0.25, y: CGRectGetMidY(self.frame) + self.frame.height * 0.4)
        enemyHealthBar = HealthBar(barLengthed: barLength, barHeight: barHeight, maxHp: enemyStat.mhp, currentHp: enemyStat.mhp)
        enemyHealthBar.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.width * 0.25, y: CGRectGetMidY(self.frame) + self.frame.height * 0.4)
        
        let retreatButton = BattleButton(texted: "撤退")
        retreatButton.fontSize = 30
        retreatButton.fontColor = UIColor.blackColor()
        retreatButton.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) - self.frame.height * 0.4)
        retreatButton.zPosition = 60
        retreatButton.delegate = self
        
        
        self.addChild(player)
        self.addChild(enemy)
        self.addChild(playerHealthBar)
        self.addChild(enemyHealthBar)
        self.addChild(retreatButton)
        
        player.delegate = self
        enemy.delegate = self
        nextAction()
    }
    
    func setRetreating() {
        self.isRetreating = true
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
            if (enemyHealthBar.hp <= 0) {
                enemy.goDie()
            }
        } else {
            playerHealthBar.damaged(finalDam)
            if (playerHealthBar.hp <= 0) {
                player.goDie()
            }
        }
    }
    
    func retrectSucc() {
        NSLog("REtrectSucc")
        retreated = true
    }
    
    func nextAction() {
        if (player.die == true || enemy.die == true) {
            if (enemy.die == true) {
                player.creatureStats.hp = playerHealthBar.hp
                let label = SKLabelNode.init(text: "击败了敌人!")
                label.fontSize = 30
                label.fontColor = UIColor.blackColor()
                label.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.width * 0.25, y: CGRectGetMidY(self.frame) - self.frame.height * 0.1)
                label.zPosition = 30
                self.addChild(label)
            } else {
                let label = SKLabelNode.init(text: "你的英勇长存人心!")
                label.fontSize = 30
                label.fontColor = UIColor.redColor()
                label.position = CGPoint(x: CGRectGetMidX(self.frame) - self.frame.width * 0.25, y: CGRectGetMidY(self.frame))
                label.zPosition = 30
                self.addChild(label)
            }
            return
        }
        if (retreated == true) {
            let label = SKLabelNode.init(text: "你可耻地逃跑了!")
            label.fontSize = 30
            label.fontColor = UIColor.redColor()
            label.position = CGPoint(x: CGRectGetMidX(self.frame) - self.frame.width * 0.25, y: CGRectGetMidY(self.frame))
            label.zPosition = 30
            self.addChild(label)
            return
        }
        if (player.turns < enemy.turns) {
            if (isRetreating == true) {
                isRetreating = false
                player.retreat(distance: stabDist * 2, level: enemy.creatureStats.dex)
            } else {
                player.stab(distance: stabDist)
            }
        } else {
            enemy.stab(distance: stabDist)
        }
    }
}
