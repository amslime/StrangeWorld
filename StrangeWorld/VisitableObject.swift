//
//  VisitableObject.swift
//  StrangeWorld
//
//  Created by wangli on 16/8/3.
//  Copyright © 2016年 wangli. All rights reserved.
//

import SpriteKit
import Foundation

class VisitableObject: SKSpriteNode {
    var zoonIn : SKAction!
    var zoonOut : SKAction!
    var scaleFac : CGFloat!
    
    convenience init(imageNamed imageName: String, objectName : String) {
        self.init(imageNamed: imageName)
        self.name = objectName
        self.userInteractionEnabled = true
        scaleFac = 2.2
        self.setScale(scaleFac)
        zoonIn = SKAction.scaleTo(scaleFac * 1.5, duration: 0.5)
        zoonOut = SKAction.scaleTo(scaleFac, duration: 0.5)
        self.zPosition = 30
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let townData = ModelHandler.Instance.townData
        let titleLabel = ViewItemHandler.Instance.townScene.titleText
        let commentLabel = ViewItemHandler.Instance.townScene.commentText
        if (ViewItemHandler.Instance.onChooseItem == nil || ViewItemHandler.Instance.onChooseItem != self.name) {
            if (ViewItemHandler.Instance.onChooseItem != nil) {
                let visitableObj = ViewItemHandler.Instance.townScene.childNodeWithName(ViewItemHandler.Instance.onChooseItem) as! VisitableObject
                visitableObj.endShrinkAction()
            }
            ViewItemHandler.Instance.onChooseItem = self.name
            let facObj = townData.getFacilityByName(facilityName: self.name!)
            let title = facObj["NAME"] as! String
            let comment = facObj["COMMENT"] as! String
            titleLabel.text = title
            commentLabel.text = comment
            self.runAction(SKAction.repeatActionForever(SKAction.sequence([zoonIn, zoonOut])))
        } else {
            endShrinkAction()
            ViewItemHandler.Instance.onChooseItem = nil
            titleLabel.text = townData.getTownName()
            commentLabel.text = townData.getTownComment()
            ViewItemHandler.Instance.switchGroundScene(sceneNamed: self.name!)
        }
    }
    
    func endShrinkAction() {
        self.removeAllActions()
        self.setScale(scaleFac)
    }
}
