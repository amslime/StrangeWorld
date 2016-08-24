//
//  GameViewController.swift
//  StrangeWorld
//
//  Created by wangli on 16/8/3.
//  Copyright (c) 2016年 wangli. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    @IBOutlet weak var logButton: UIBarButtonItem!
    @IBOutlet weak var charButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
        ModelHandler.Instance.resetFromView()
        ViewItemHandler.Instance.setViewController(self)
        let scene = TownScene(size: self.view.frame.size)
            // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            
        skView.presentScene(scene)
        ViewItemHandler.Instance.setTownScene(scene)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        charButton.enabled = true
        logButton.enabled = true
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func charButtonClicked(sender : AnyObject) {
        charButton.enabled = false
        ViewItemHandler.Instance.switchPlayerScene()
    }
    
    @IBAction func logButtonClicked(sender : AnyObject) {
        logButton.enabled = false
        ViewItemHandler.Instance.switchLogScene()
    }
    
}
