//
//  GameScene.swift
//  StrangeWorld
//
//  Created by wangli on 16/8/3.
//  Copyright (c) 2016年 wangli. All rights reserved.
//

import SpriteKit

class TownScene: SKScene {
    var titleText: UILabel!
    var commentText: UILabel!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let navHeight = ViewItemHandler.Instance.gameViewController.navigationController?.navigationBar.frame.height
        let sceneHeight = self.frame.height - navHeight!
        let backgroundNode = SKSpriteNode(imageNamed: "Town00.jpg")
        backgroundNode.size.height = self.frame.height
        backgroundNode.size.width = self.frame.width * 0.8
        NSLog("%f", self.frame.size.width)
        NSLog("%f", view.frame.size.width)
        NSLog("%f", self.frame.size.height)
        backgroundNode.anchorPoint = CGPoint.zero
        backgroundNode.position = CGPoint.zero
        self.backgroundColor = SKColor.blackColor()
        self.addChild(backgroundNode)
        
        if (titleText == nil) {
            titleText = UILabel(frame: CGRect(x: self.frame.width * 0.8, y: 0, width: self.frame.width * 0.2, height: sceneHeight * 0.1))
            titleText.backgroundColor = UIColor.brownColor()
            titleText.textColor = UIColor.cyanColor()
            titleText.textAlignment = .Center
            view.addSubview(titleText)
        }
        if (commentText == nil) {
            commentText = UILabel(frame: CGRect(x: view.frame.width * 0.8, y: sceneHeight * 0.1, width: self.frame.width * 0.2, height: sceneHeight * 0.9))
            commentText.lineBreakMode = .ByCharWrapping
            commentText.numberOfLines = 0
            commentText.textColor = UIColor.whiteColor()
            commentText.backgroundColor = UIColor.grayColor()
            commentText.textAlignment = .Center
            view.addSubview(commentText)
        }

        let townData =  ModelHandler.Instance.townData
        titleText.text = townData.getTownName()
        commentText.text = townData.getTownComment()
        
        let facilities = townData.getFacilitiesList()
        for facName: String in facilities {
            NSLog(facName)
            let fac = townData.getFacilityByName(facilityName: facName) 
            let xScale = fac["X"] as! CGFloat
            let yScale = fac["Y"] as! CGFloat
            let facObject = VisitableObject(imageNamed: "in.png", objectName: facName)
            facObject.position = CGPoint(x:backgroundNode.size.width * xScale, y: backgroundNode.size.height * yScale)
            self.addChild(facObject)
        }
        
    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
