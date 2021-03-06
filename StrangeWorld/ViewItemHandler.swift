//
//  ViewItemHandler.swift
//  StrangeWorld
//
//  Created by wangli on 16/8/3.
//  Copyright © 2016年 wangli. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class ViewItemHandler {
    class var Instance: ViewItemHandler {
        struct Static {
            static var instance: ViewItemHandler?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ViewItemHandler()
        }
        return Static.instance!
    }
    
    var townScene : TownScene!
    var gameViewController : GameViewController!
    var groundSceneMap : Dictionary<String, UIViewController>!
    private var playerCharScene : UIViewController!
    private var logScene : UIViewController!
    
    var onChooseItem: String!
    
    func setTownScene(townScene : TownScene) {
        self.townScene = townScene
    }
    
    func setViewController(viewController : GameViewController) {
        self.gameViewController = viewController
    }
    
    func switchGroundScene(sceneNamed name : String) {
        if (groundSceneMap == nil) {
            NSLog("nil")
            groundSceneMap = Dictionary<String, UIViewController>()
        }
        if (groundSceneMap[name] == nil) {
            NSLog("nil2")
            let viewController = gameViewController.storyboard?.instantiateViewControllerWithIdentifier(name)
            groundSceneMap[name] = viewController
        }
        gameViewController.navigationController?.pushViewController(groundSceneMap[name]!, animated: true)
    }
    
    func switchPlayerScene() {
        if (playerCharScene == nil) {
            NSLog("playerscenenil")
            playerCharScene = gameViewController.storyboard?.instantiateViewControllerWithIdentifier("PLAYER_BOARD")
        }
        gameViewController.navigationController?.pushViewController(playerCharScene, animated: true)
    }
    
    func switchLogScene() {
        if (logScene == nil) {
            NSLog("logscenenil")
            logScene = gameViewController.storyboard?.instantiateViewControllerWithIdentifier("LOG_BOARD")
        }
        gameViewController.navigationController?.pushViewController(logScene, animated: true)
    }

}
