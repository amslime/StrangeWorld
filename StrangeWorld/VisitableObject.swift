//
//  VisitableObject.swift
//  StrangeWorld
//
//  Created by wangli on 16/8/3.
//  Copyright © 2016年 wangli. All rights reserved.
//

import SpriteKit

class VisitableObject: SKSpriteNode {
    var highlighted : Bool!
    var zoonIn : SKAction!
    var zoonOut : SKAction!
    
    convenience init(imageNamed imageName: String, objectName : String) {
        self.init(imageNamed: imageName)
        self.name = objectName
        self.userInteractionEnabled = true
        self.highlighted = false
        zoonIn = SKAction.scaleTo(1.05, duration: 0.5)
        zoonOut = SKAction.scaleTo(1.00, duration: 0.5)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (self.highlighted == false) {
            self.highlighted = true
            self.runAction(SKAction.repeatActionForever(SKAction.sequence([zoonIn, zoonOut])))
        } else {
            self.highlighted = false
            self.removeAllActions()
            self.setScale(1.0)
            ViewItemHandler.Instance.switchGroundScene(sceneNamed: self.name!)
        }
    }
}
