//
//  Button.swift
//  StrangeWorld
//
//  Created by wangli on 16/8/18.
//  Copyright © 2016年 wangli. All rights reserved.
//

import Foundation
import SpriteKit

class BattleButton : SKLabelNode {
    weak var delegate: BattleMainScene!
    convenience init(texted name : String) {
        self.init()
        self.text = name
        self.userInteractionEnabled = true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        NSLog("touch retreat")
        self.delegate?.setRetreating()
    }

}