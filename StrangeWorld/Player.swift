//
//  Player.swift
//  StrangeWorld
//
//  Created by wangli on 16/8/4.
//  Copyright © 2016年 wangli. All rights reserved.
//

import Foundation

class Player {
    var str, dex, def, mhp: Int!
    var dict: Dictionary<String, AnyObject?>!
    
    func load(fromDictionary dict : Dictionary<String, AnyObject?>) {
        self.dict = dict
        self.str = dict["STR"] as! Int
        self.dex = dict["DEX"] as! Int
        self.def = dict["DEF"] as! Int
        self.mhp = dict["HP"] as! Int
        NSLog("mhp%d", self.mhp)
    }
    
}
