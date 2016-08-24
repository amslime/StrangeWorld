//
//  DungeonSceneController.swift
//  StrangeWorld
//
//  Created by wangli on 16/8/22.
//  Copyright © 2016年 wangli. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class DungeonSceneController : UIViewController {
    var scrollView: UIScrollView!
    var backgroundView: UIImageView!
    var maskLayer: CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navHeight = ViewItemHandler.Instance.gameViewController.navigationController?.navigationBar.frame.height
        let sceneHeight = self.view.frame.height - navHeight!
        let sceneWidth = self.view.frame.width
        self.view.backgroundColor = UIColor.blackColor()
        scrollView = UIScrollView(frame: CGRect(x: sceneWidth * 0.35 + 5, y: 5, width: sceneWidth * 0.65 - 10, height: sceneHeight - 10))
        NSLog("%f", self.view.frame.size.height)

        backgroundView = UIImageView(image: UIImage(named: "Town00.jpg"))
        backgroundView.frame.size.height = 600
        backgroundView.frame.size.width = 800
        maskLayer = CAShapeLayer()
        maskLayer.frame = backgroundView.frame
        maskLayer.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.05).CGColor
        backgroundView.layer.mask = maskLayer
        backgroundView.clipsToBounds = true
        
        let button = UIButton(type: UIButtonType.RoundedRect)
        button.setImage(UIImage(named: "in.png"), forState: .Normal)
        button.imageView?.contentMode = UIViewContentMode.Center
        button.frame = CGRect(x: 30, y: 30, width: 40, height: 40)
        button.addTarget(self, action: #selector(DungeonSceneController.onClick), forControlEvents: UIControlEvents.TouchUpInside)
        button.userInteractionEnabled = true
        
        
        createLightArea(CGPointMake(50, 50), radius: 200)

        
        scrollView.contentSize = backgroundView.frame.size
        scrollView.addSubview(backgroundView)
        scrollView.addSubview(button)
        
        self.view.addSubview(scrollView)
    }
    
    func onClick(sender: AnyObject) {
        NSLog("click")
        let button = sender as! UIButton
        button.tintColor = UIColor.greenColor()
        createLightArea(CGPointMake(120, 120), radius: 200)

    }
    
    func createLightArea(pos : CGPoint, radius : CGFloat) {
        let path = CGPathCreateMutable()
        CGPathAddArc(path, nil, pos.x, pos.y, radius, 0.0, 2.0 * CGFloat(M_PI), false)
        maskLayer.path = path
        maskLayer.fillRule = kCAFillRuleEvenOdd
    }
}
