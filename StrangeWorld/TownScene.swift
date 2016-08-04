//
//  GameScene.swift
//  StrangeWorld
//
//  Created by wangli on 16/8/3.
//  Copyright (c) 2016年 wangli. All rights reserved.
//

import SpriteKit

class TownScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        let sprite = VisitableObject(imageNamed: "Spaceship", objectName: "Tarven")
        sprite.xScale = 1
        sprite.yScale = 1
        sprite.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(sprite)
    }
       
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
